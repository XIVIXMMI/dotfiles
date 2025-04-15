{ config, lib, pkgs, ... }:

{
  # This is the system-level config
  # For user-level config, see the home-manager part

  environment.systemPackages = with pkgs; [
    waybar
  ];

  # You can add any system-level configuration for waybar here
  # Most of the waybar configuration will be in home-manager
}
