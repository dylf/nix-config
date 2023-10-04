{
  description = "My Nix Configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (self: super: {
          waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          });
        })
      ];
    };

  in
  {

  nixosConfigurations = {
    myNixOs = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system; };

      modules = [
        ./lib/nixos/configuration.nix
      ];
    };
  };

  };

}
