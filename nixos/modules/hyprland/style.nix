{ config, lib, pkgs, ... }:

{
  # System-level theming for Hyprland
  # This might include fonts, GTK theme, cursor theme, etc.
  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
  ];
  
  # Make sure GTK applications look nice in Wayland
  programs.dconf.enable = true;
}
