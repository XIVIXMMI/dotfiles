{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./waybar.nix
    ./style.nix
    ./keybinds.nix
  ];

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # System-level packages needed for Hyprland
  environment.systemPackages = with pkgs; [
    wayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    grim # Screenshot utility
    slurp # Region selection for screenshots
    wl-clipboard # Wayland clipboard utilities
    wofi # Application launcher
    hyprpaper # Wallpaper tool for Hyprland
    swaylock # Screen locker
    swayidle # Idle management daemon
    mako # Notification daemon
    brightnessctl # Brightness control
    pamixer # PulseAudio command-line mixer
  ];

  security.pam.services.swaylock = {}; # Allow swaylock to unlock the system

  # Ensure your user is in the necessary groups
  users.users.omori.extraGroups = [ "video" "input" ];

  # Allow Hyprland alongside GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
  };
}
