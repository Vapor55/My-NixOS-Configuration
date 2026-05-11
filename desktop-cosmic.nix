{ config, pkgs, ... }:

{
  # Enable Cosmic
  services.desktopManager.cosmic.enable = true;

  # Display Manager

  services.displayManager = {
    cosmic-greeter = {
      enable = true;
    };
  };

  # System76's own Scheduler otimization
  services.system76-scheduler.enable = true;

  # Bypass clipboard Cosmic
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
}
