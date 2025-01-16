{ flake, pkgs, ... }:
let
  nodejs = pkgs.nodejs_24;
  pnpm = pkgs.pnpm_11.override { inherit nodejs; };
in
flake.lib.mkMinimalShell pkgs {
  name = "grace-kimbutler-xyz-devshell";

  packages = [
    nodejs
    pnpm
    (pkgs.typescript-language-server.override { inherit nodejs; })
    flake.formatter.${pkgs.stdenv.system}.passthru.formatters.oxfmt
  ];
}
