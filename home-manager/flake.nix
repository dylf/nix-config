{
  description = "Home Manager configuration of dylf";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nvimConfig = {
      url = "github:dylf/nvim-config";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, nvimConfig, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."dylf" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
	  ./home.nix
	  hyprland.homeManagerModules.default
	  {wayland.windowManager.hyprland.enable = true;}
	];

	extraSpecialArgs = { inherit nvimConfig; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
