# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

let
  localGrubTheme = pkgs.stdenv.mkDerivation {
    pname = "alya-grub-theme";
    version = "1.0";
    src = ./Assets/Grub/Theme/alya-grub-theme;
    installPhase = ''
      mkdir -p $out/share/grub/themes/alya-grub-theme
      cp -r * $out/share/grub/themes/alya-grub-theme/
    '';
  };
in

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  # NixOS Flakes

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # GRUB default bootloader

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
      theme = "${localGrubTheme}/share/grub/themes/alya-grub-theme"; # path to your grub theme
    };
  };

  # Modprobe options

  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';

  networking.hostName = "Gui-Negativo-2"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable Bluetooth and Blueman

  hardware.bluetooth = {
    enable = true;
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/Belem";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "br";
  services.xserver.xkb.variant = "abnt2";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    audio.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.guilherme = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = true;
    shell = pkgs.zsh; 
    packages = with pkgs; [
      tree
    ];
  };

  # Enable Z-Shell

  programs.zsh.enable = true;

  # NH helper

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you  
  };

  # Zram

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    swapDevices = 1;
    priority = 100;
    # writebackDevice = "/dev/sdXN";
  };

  # Display Manager

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;

      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-macchiato-mauve";
    };

    autoLogin = {
      enable = true;
      user = "guilherme";
    };
  };

  # GVFS, UDisks2 and Polkit needed for Dolphin in Hyprland

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  # };

  # Niri

  programs.niri.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1 slack --wayland-text-input-version=3"; 

  programs.waybar.enable = true;

  # System Packages

  environment.systemPackages = with pkgs; [

    # SDDM Theme

    (catppuccin-sddm.override {
      flavor = "macchiato";
      accent = "mauve";
      font  = "Noto Fonts";
      fontSize = "9";
      background = "${./Assets/Background/virtual_bg_01_unit06.png}";
      loginBackground = true;
    })

    # Niri needed Packages

    kitty
    nemo-with-extensions
    fuzzel
    swaylock
    libnotify
    mako
    wl-clipboard
    swayidle
    swaybg
    slurp
    grim
    swappy
    wf-recorder
    xwayland-satellite

    # Dolphin File Manager

    # kdePackages.dolphin # This is the actual dolphin package
    # kdePackages.dolphin-plugins # for extra dolphin features like archive handling, trash support, etc. 
    # kdePackages.kio-gdrive # to access Google Drive filesystems
    # kdePackages.kio # needed since 25.11
    # kdePackages.kio-fuse #to mount remote filesystems via FUSE
    # kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    # kdePackages.qtsvg

    # Others Hyprland necessary packages

    # hyprpolkitagent
    # mpvpaper
    # hyprpaper
    # wofi

    # Others Packages

    networkmanagerapplet
    gparted
    vim-full
    file-roller
    unzip
    unrar
    p7zip

    # support both 32-bit and 64-bit applications
    wineWowPackages.stable

    # support 32-bit only
    wine

    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # support 64-bit only
    wine64

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ]; 

  # Flatpak

  services.flatpak.enable = true;

  # KDE Connect

  programs.kdeconnect.enable = true;

  # Steam

  programs.steam = {
    enable = true;
    # gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Waydroid to play Clash Royale and Hatsune Miku: Colorful Stage

  virtualisation.waydroid.enable = true;

  # Allow unfree package to Steam

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "unrar"
  ];

  # Fonts

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    pkgs.font-awesome
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
    nerd-fonts.space-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
  ];

  fonts.fontconfig.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}

