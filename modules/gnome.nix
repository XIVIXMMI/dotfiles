{ config, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap
  services.xserver.xkb.layout = "us";

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Install GNOME applications
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany    # Web browser
    totem       # Video player
    geary       # Email client
    tali        # Game
    iagno       # Game
    hitori      # Game
    atomix      # Game
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
    adwaita-icon-theme
    gnome-extension-manager
    
    # Additional GNOME applications
    gnome-calendar
    gnome-calculator
    gnome-system-monitor
    gnome-screenshot
    gnome-terminal
    eog            # Image viewer
    evince         # Document viewer
  ];

  # Enable GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable CUPS for printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
}
