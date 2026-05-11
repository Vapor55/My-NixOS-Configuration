{ config, pkgs, ... }:

{
  security.sudo.enable = false;

  security.doas.enable = true;
  security.doas.extraRules = [{
    users = ["hitori"];
    # Optional, retains environment variables while running commands 
    # e.g. retains your NIX_PATH when applying your config
    keepEnv = true; 
    persist = true;  # Optional, don't ask for the password for some time, after a successfully authentication
  }];

  # If using a flakes-based configuration, you'll need `git` in your system packages for system rebuilds
  environment.systemPackages = [ pkgs.git ];
}
