{ pname, pkgs, ... }:
let
  treefmtConfigFile = (pkgs.formats.toml { }).generate "treefmt.toml" {
    formatter.hcl = {
      command = "tofu";
      options = [ "fmt" ];
      includes = [ "*.tf" "*.tfvars" "*.tftest.hcl" ];
    };
    formatter.nix = {
      command = "nixpkgs-fmt";
      includes = [ "*.nix" ];
    };
  };
  runtimeInputs = [
    pkgs.deadnix
    pkgs.nixpkgs-fmt
    pkgs.opentofu
    pkgs.treefmt
  ];
in
pkgs.writeShellApplication {
  name = pname;

  inherit runtimeInputs;

  passthru = { inherit runtimeInputs; };

  text = ''
    deadnix --edit "$@"
    treefmt --config-file "${treefmtConfigFile}" "$@"
  '';

  meta.description = "Format the Kim-Butler flake";
}
