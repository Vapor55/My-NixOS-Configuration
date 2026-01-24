{
  description = "Flake do Gui by Deive";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {self, nixpkgs, nix-cachyos-kernel, home-manager, } @ inputs: {
    
    nixosConfigurations = {
      "Gui-Negativo-2" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [

          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                # Build the kernels on top of nixpkgs version in your flake.
                # Binary cache may be unavailable for the kernel/nixpkgs version combos.
                nix-cachyos-kernel.overlays.default

                # Alternatively: use the exact kernel versions as defined in this repo.
                # Guarantees you have binary cache.
                nix-cachyos-kernel.overlays.pinned

                # Only use one of the two overlays!
              ];

              # ... your other configs 
            }
          )

          ./configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "guilherme@Gui-Negativo-2" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./home.nix ];
      };
    };
  };
}

