# My **NixOS** Configuration

# Desktop Images

![Hyprland desktop screenshot with KAngel from Needy Streamer Overload](./Assets/Images/0001.png) ![Hyprland desktop screenshot with KAngel from Needy Streamer Overload with Windows type terminal with fastfetch, etc](./Assets/Images/0002.png)

# INSTALLATION

## Requisits

* NixOS ISO Installation
* Internet Connection
* Git

## Install

Install an [Minimal ISO image](https://nixos.org/download/).

Read the NixOS Installation [Manual](https://nixos.org/manual/nixos/stable/#sec-installation) until the part to connect an Internet.

After booted the NixOS ISO Installation, connected to Internet, partition the disk. Ex: /dev/sda.

> [!NOTE]
> If you decide use Systemd-boot instead of Grub (used on my configuration) or use MBR, mount the boot partition on /boot instead of /boot/efi.
> If you prefere partition the disk with official NixOS Manual, follow the [NixOS Manual](https://nixos.org/manual/nixos/stable/#sec-installation).

### Make Partitions

1. Create a MBR partition table.

```bash
parted /dev/sda -- mklabel msdos
```

Or if you use GPT instead of legacy MBR.

```bash
parted /dev/sda -- mklabel gpt
```

2. Create a **boot** partition.

I. Boot partition on MBR.

```bash
parted /dev/sda -- mkpart primary ext4 1MB 512MB
```

Set boot partition boot flag.

```bash
parted /dev/sda -- set 1 boot on
```

II. ESP partition on GPT.

```bash
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
```

Set EFI partition ESP flag.

```bash
parted /dev/sda -- set 3 esp on
```

3. Swap partition.

Example: 4GB (adjust as needed).

```bash
parted /dev/sda -- mkpart swap linux-swap 512MB 4GB
```

4. Root partition

**WARING**: The first 4GB is an your Swap Partition, adjust for your an swap partition size.

Use total disk for a root partition.

```bash
parted /dev/sda -- mkpart root ext4 4GB 100%
```

Or your decide create a /home partition after created a root partition.

Example: 32GB for a root partition (adjust as needed).

```bash
parted /dev/sda -- mkpart root ext4 4GB 32GB
```

5. /home partition (optional)

**WARING**: The 32GB is an your root partition, adjust for your an root partition size.

```bash
parted /dev/sda -- mkpart root ext4 32GB 100%
```

### Format Partitions

1. Boot partition

I. Legacy MBR

```bash
mkfs.ext4 -L boot /dev/sda1
```
II. EFI partition

```bash
mkfs.vfat -F 32 -n boot /dev/sda1
```

2. Swap partition.

```bash
mkswap -L swap /dev/sda2
```

3. Root partition.

```bash
mkfs.ext4 -L nixos /dev/sda3
```

4. /home partition (optional)

```bash
mkfs.ext4 -L home /dev/sda4
```

Mount the partitions.

1. Root partition

```bash
mount /dev/disk/by-label/nixos /mnt
```

2. Boot partition

I. In MBR.

```bash
mkdir -p /mnt/boot
```

```bash
mount /dev/disk/by-label/boot /mnt/boot
```

II. In GPT.

```bash
mkdir -p /mnt/boot/efi
```

```bash
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot/efi
```

3. Swap partition.

```bash
swapon /dev/sda3
```

4. /home partition (optional).

```bash
mkdir -p /mnt/home
```

```bash
mount /dev/disk/by-label/home /mnt/home
```

### Configurate NixOS before install

1. Generate Nix Configuration.

```bash
nixos-generate-config --root /mnt
```

2. Temporary install Git.

```bash
nix-shell -p git
```

After sucess install, you enter in shell similar to this:

```bash
[nix-shell:~]#
```

Enter the root partition.

```bash
cd /mnt
```

Clone the my NixOS configuration repository.

```bash
git clone https://github.com/Vapor55/My-NixOS-Configuration.git
```
After clone, enter to repository folder

```bash
cd My-NixOS-Configuration
```

WARING: Remove the .git folder and hardware-configuration.nix

```bash
rm -rf .git/ hardware-configuration.nix
```

Now copy the repository content to /mnt/etc/nixos

```bash
cp -rv * /mnt/etc/nixos
```

Now enter in /mnt/etc/nixos directory

```bash
cd /mnt/etc/nixos
```

Edit the configuration

```bash
nano configuration.nix
```
Or your favorite editor

WARING: If your use MBR partition table, edit the boot.loader part to this:

```nix
boot.loader = {
  efi.enable = false;

  grub = {
    enable = true;
    device = "/dev/sda"; # Or your correct disk
  };
  grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
    customResolution = "1920x1080";  # Optional: Set a custom resolution
  };
};
```

Optional: Change the hostname.

Edit the part of configuration.nix.

```nix
networking.hostName = "your-hostname"; # Define your hostname.
```

Edit the flake.nix too.

```nix
nixosConfigurations = {
     "your-hostname" = nixpkgs.lib.nixosSystem { # Change this your-hostname for your hostname.
       ...
     };
   };
```

Optional: Change the user name.

Edit the configuration.nix

```nix
  users.users.your-username = { # Change your-username for your user name.
    ...
  };
```

Edit home.nix too

```nix
  home.username = "your-username"; # Change your-username for your user name.
  home.homeDirectory = "/home/your-username";
```

After all changes, hour to install nixos.

Install NixOS.

```bash
nixos-install --flake '/mnt/etc/flake.nix#your-hostname' # Change your-hostname to your hostname.
```

After install NixOS, it ask root password.

```bash
setting root password...
New password:
Retype new password:
```

You need password to your default user.

```bash
nixos-enter --root /mnt -c 'passwd your-username'
```

Now press Ctrl + D or type:

```bash
exit
```

And type:

```bash
reboot
```
To reboot system.

Now enter in NixOS and be happy 😁

# Others repository to complement NixOS dotfiles

[My Hyprland Dotfiles](https://gitlab.com/vapor55-group/My-Hyprland-Dotfiles)

[KAngel Fastfetch Dotfiles](https://github.com/Vapor55/KAngel-Fastfetch-Dotfiles)

# Credits

Thanks to [Deive](https://github.com/HavanaHL) to maked my Flakes.

![NixOS logo animated](./Assets/Images/nixos.gif)
