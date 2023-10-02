{ pkgs, inputs, ... }: inputs.devenv.lib.mkShell {
  inherit pkgs inputs;
  modules = [
    ({ config, pkgs, ... }: {
      packages = [
        pkgs.terraform
        pkgs.awscli2
        (pkgs.writeScriptBin "deploy-production" ("#!${pkgs.nushell}/bin/nu\n\n" + builtins.readFile ./bin/deploy-production.nu))
      ];

      env = rec {
        name = "kimbutler-devshell";
        CLOUDFLARE_API_TOKEN_FILE = "${config.env.DEVENV_ROOT}/secrets/cloudflare-api-token";
        TF_DATA_DIR = "${config.env.DEVENV_STATE}/terraform";
        TF_VAR_cloudflare_api_token_file = CLOUDFLARE_API_TOKEN_FILE;
        AWS_PROFILE = "production";
        AWS_SHARED_CREDENTIALS_FILE = "${config.env.DEVENV_ROOT}/secrets/aws-credentials";
      };
    })
  ];
}
