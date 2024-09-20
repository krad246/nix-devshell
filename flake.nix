{
  inputs = {
    nix-systems = {
      url = "github:krad246/nix-systems";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];
      systems = ["x86_64-linux"];
      perSystem = {inputs', system, ...}: {
        inherit (inputs'.nix-systems) formatter;
        packages = { 
            devshell = inputs'.nix-systems.packages."docker/devshell"; 
        };
        devShells = {
            default = inputs'.nix-systems.devShells."docker/${system}";
        };
      };
    };
}
