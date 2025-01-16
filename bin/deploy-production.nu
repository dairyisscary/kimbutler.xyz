const ONE_YEAR = 31536000
const FIVE_MINUTES = 300

def build_assets [] {
  print 'Building assets'
  cd ($env.DEVENV_ROOT | path join domains/grace)
  rm -rf dist
  ^nix develop '.#grace' --no-pure-eval --command pnpm install --frozen-lockfile
  ^nix develop '.#grace' --no-pure-eval --command pnpm build
  cd -
}

def provision_infrastructure [] {
  print 'Forming infrastructure'
  cd ($env.DEVENV_ROOT | path join infra)
  ^tofu init
  ^tofu apply
  cd -
}

def get_tf_output [] {
  print 'Getting TF output'
  cd ($env.DEVENV_ROOT | path join infra)
  let output = ^tofu output -json | from json
  cd -
  $output
}

def upload_assets [tf_output] {
  print 'Uploading assets to S3'
  let dist_path = ($env.DEVENV_ROOT | path join domains/grace/dist)
  let bucket_name = $tf_output.grace_static_bucket_name.value

  # HTML and Page Data that can't be (browser) cached
  let page_uploads = (
    ^aws s3 cp --recursive --metadata-directive REPLACE --no-progress
      --cache-control $'public, max-age=($FIVE_MINUTES), s-maxage=($ONE_YEAR), must-revalidate'
      --exclude '*' --include '*.html'
      --content-type 'text/html; charset=utf-8'
      $dist_path $'s3://($bucket_name)'
  ) | lines

  # Static assets and JS/CSS that can be cached forever
  let immutable_uploads = (
    ^aws s3 cp --recursive --metadata-directive REPLACE --no-progress
      --cache-control $'public, max-age=($ONE_YEAR), immutable'
      ($dist_path | path join '_astro') $'s3://($bucket_name)/_astro'
  ) | lines

  print ($page_uploads | append $immutable_uploads)
}

def purge_cdn [tf_output] {
  print 'Purging CDN cache'
  let cf_zone_id = $tf_output.cloudflare_zone_id.value
  let cf_api_token = (open --raw $env.CLOUDFLARE_API_TOKEN_FILE | str trim)

  (
    http post
      -t application/json
      -H [Authorization $'Bearer ($cf_api_token)']
      $'https://api.cloudflare.com/client/v4/zones/($cf_zone_id)/purge_cache'
      {purge_everything: true}
  )
}

def main [] {
  build_assets
  provision_infrastructure
  let tf_output = get_tf_output
  upload_assets $tf_output
  purge_cdn $tf_output
}
