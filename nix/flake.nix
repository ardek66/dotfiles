{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lan-mouse.url = "github:feschber/lan-mouse";
    shadowrz.url = "github:ShadowRZ/nur-packages/8522a81";
    shadowrz.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.url = "sourcehut:~rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, shadowrz, firefox-addons, nixos-hardware, home-manager, lan-mouse, ... }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      lain-iwakura = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
	        nixos-hardware.nixosModules.lenovo-thinkpad-t430
          ./t430.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	          home-manager.users.idf = ./home/t430.nix;

            home-manager.extraSpecialArgs = { inherit lan-mouse firefox-addons; };
          }
        ];
      };

     alisu-mizuki = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [
         nixos-hardware.nixosModules.lenovo-ideapad-15ach6
         ./15ach6.nix
         home-manager.nixosModules.home-manager
         {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.idf = ./home/15ach6.nix;

           home-manager.extraSpecialArgs = { inherit lan-mouse firefox-addons; };
        }
      ];
     };
    };
  };
}
