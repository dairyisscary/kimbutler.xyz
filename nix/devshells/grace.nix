{ flake, pkgs, ... }:
flake.lib.mkMinimalShell pkgs {
  name = "grace-kimbutler-xyz-devshell";

  packages = [
    pkgs.nodejs-slim_22
    pkgs.nodePackages.pnpm
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.prettier
  ];
}
