{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
    	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.belle = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
      	./hosts/desktop/configuration.nix
	home-manager.nixosModules.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.freddy = import ./hosts/desktop/home.nix;
	    backupFileExtension = "bak";
	  };
	}
      ];
    };
  };
}
