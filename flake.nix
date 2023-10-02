{
  description = "The online presence of kimbutler.xyz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, devenv, ... }:
    let
      forAllSystems = mapFn: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (system: mapFn {
        inherit system inputs;
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      formatter = forAllSystems (args: args.pkgs.nixpkgs-fmt);

      devShells = forAllSystems (args: rec {
        default = infrastructure;
        grace = import ./domains/grace/shell.nix args;
        infrastructure = import ./shell.nix args;
      });
    };
}
