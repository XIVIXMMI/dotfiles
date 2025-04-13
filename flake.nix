{
  description = "NixOS configuration for ThinkPad X270";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."thinkpad-x270" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/thinkpad-x270.nix
	  ./hardware/x270.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.omori = import ./home/omori/home.nix;
          }
          nixos-hardware.nixosModules.lenovo-thinkpad-x270
        ];
      };
    };
}
