{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = [
        config.treefmt.build.devShell
        config.pre-commit.devShell

        config.flake-root.devShell
      ];
    };
  };
}
