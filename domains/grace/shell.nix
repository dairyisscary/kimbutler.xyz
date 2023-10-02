{ pkgs, inputs, ... }: inputs.devenv.lib.mkShell {
  inherit pkgs inputs;
  modules = [
    ({ pkgs, ... }: {
      packages = [
        pkgs.nodejs-slim
        pkgs.nodePackages.pnpm
        pkgs.nodePackages.typescript-language-server
        pkgs.nodePackages.prettier
      ];

      env.name = "grace-kimbutler-devshell";
    })
  ];
}
