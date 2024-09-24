{
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    just-flake.features = {
      treefmt = {
        enable = true;
      };

      git = {
        enable = true;
        justfile = ''
          [no-exit-message]
          git *ARGS:
              ${lib.getExe pkgs.git} {{ ARGS }}
        '';
      };

      add = {
        enable = true;
        justfile = ''
          add +ARGS="-u": (git "add" "--chmod=+x" ARGS)
        '';
      };

      commit = {
        enable = true;
        justfile = ''
          commit +ARGS="--dry-run": (add "-u") (git "commit" ARGS)
        '';
      };

      amend = {
        enable = true;
        justfile = ''
          amend +ARGS="--dry-run": (add "-u") (commit "--amend" ARGS)
        '';
      };
    };
  };
}
