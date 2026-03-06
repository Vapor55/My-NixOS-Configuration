{
  description = "Flake do Gui by Deive";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # Do not override its nixpkgs input, otherwise there can be mismatch between patches and kernel version

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {self, nixpkgs, lanzaboote, nix-cachyos-kernel, home-manager, } @ inputs: {

    nixosConfigurations = {
      "Gui-Negativo-2" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          # This is not a complete NixOS configuration and you need to reference
          # your normal configuration here.

          lanzaboote.nixosModules.lanzaboote

          ({ pkgs, lib, ... }: {

            environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot.
              pkgs.sbctl
            ];

            # Lanzaboote currently replaces the systemd-boot module.
            # This setting is usually set to true in configuration.nix
            # generated at installation time. So we force it to false
            # for now.
            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          })        

        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [
              # Use the exact kernel versions as defined in this repo.
              # Guarantees you have binary cache.
              nix-cachyos-kernel.overlays.pinned

              # Alternatively, build the kernels on top of nixpkgs version in your flake.
              # This might cause version mismatch/build failures!
              # nix-cachyos-kernel.overlays.default

              # Only use one of the two overlays!
            ];

            # CachyOS kernel binary
            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

            # Binary cache
            nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
            nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

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
