{ pkgs, inputs, ... }: inputs.devenv.lib.mkShell {
  inherit pkgs inputs;
  modules = [
    ({ config, pkgs, ... }: {
      packages = [
        pkgs.terraform
        pkgs.awscli2
        (pkgs.writeScriptBin "deploy-production" ("#!${pkgs.nushell}/bin/nu\n\n" + builtins.readFile ./bin/deploy-production.nu))
      ];

      env =
        let
          inherit (config.env) DEVENV_ROOT DEVENV_STATE;
          secretsDir = "${DEVENV_ROOT}/secrets";
          cloudflareAPITokenFile = "${secretsDir}/cloudflare-api-token";
        in
        {
          name = "kimbutler-devshell";
          CLOUDFLARE_API_TOKEN_FILE = cloudflareAPITokenFile;
          TF_DATA_DIR = "${DEVENV_STATE}/terraform";
          TF_VAR_cloudflare_api_token_file = cloudflareAPITokenFile;
          TF_VAR_cloudflare_theater_tunnel_password_file = "${secretsDir}/cloudflare-theater-tunnel-password";
          AWS_PROFILE = "production";
          AWS_SHARED_CREDENTIALS_FILE = "${secretsDir}/aws-credentials";
        };
    })
  ];
}
