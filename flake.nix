{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    ...
  } @ inputs: {
    nixosConfigurations.belle = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/desktop/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.freddy = import ./hosts/desktop/home.nix;
            backupFileExtension = "bak";
          };
        }
      ];
    };

    nixosConfigurations.jane= nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        ./hosts/work/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.freddy = import ./hosts/work/home.nix;
            backupFileExtension = "bak";
          };
        }
      ];
    };
  };
}
