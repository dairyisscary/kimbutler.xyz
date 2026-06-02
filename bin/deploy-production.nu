const ONE_YEAR = 31536000
const FIVE_MINUTES = 300

def "path grace" [] {
  $env.XYZ_ROOT | path join domains/grace
}

def "path infra" [] {
  $env.XYZ_ROOT | path join infra
}

def build_assets [] {
  print 'Building assets'
  cd (path grace)
  rm -rf dist
  ^nix develop '.#grace' --command pnpm install --frozen-lockfile
  ^nix develop '.#grace' --command pnpm build
  cd -
}

def provision_infrastructure [] {
  print 'Forming infrastructure'
  cd (path infra)
  ^tofu init
  ^tofu apply
  cd -
}

def get_tf_output [] {
  print 'Getting TF output'
  cd (path infra)
  let output = ^tofu output -json | from json
  cd -
  $output
}

def upload_assets [tf_output] {
  print 'Uploading assets to S3'

  let dist_path = path grace | path join .output/public
  let public_path = path grace | path join public

  let s3_uri_root = $'s3://($tf_output.grace_static_bucket_name.value)'

  let short_lived_cache_control = $'public, max-age=($FIVE_MINUTES), s-maxage=($ONE_YEAR), must-revalidate'

  # HTML with a short-lived cache
  let page_uploads = (
    ^aws s3 cp --recursive --metadata-directive REPLACE --no-progress
      --cache-control $short_lived_cache_control
      --exclude '*' --include '*.html'
      --content-type 'text/html; charset=utf-8'
      $dist_path $s3_uri_root
  ) | lines

  # "Public" files with short-lived cache
  let public_uploads = (
    ^aws s3 cp --recursive --metadata-directive REPLACE --no-progress
      --cache-control $short_lived_cache_control
      $public_path $s3_uri_root
  ) | lines

  # Static assets and JS/CSS that can be cached forever
  let immutable_uploads = (
    ^aws s3 cp --recursive --metadata-directive REPLACE --no-progress
      --cache-control $'public, max-age=($ONE_YEAR), immutable'
      ($dist_path | path join '_build') $'($s3_uri_root)/_build'
  ) | lines

  print ($page_uploads | append $immutable_uploads | append $public_uploads)
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
