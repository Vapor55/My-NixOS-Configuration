{ config, pkgs, ...}:

{
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
        inhibit_screensaver = 0;
      };

    # Warning: GPU optimisations have the potential to damage hardware
    gpu = {
      apply_gpu_optimisations = "accept-responsibility";
      gpu_device = 0;
    };

      custom = {
        start = "notify-send -a 'Gamemode' 'Optimizations activated'";
        end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
      };
    };
  };
}
