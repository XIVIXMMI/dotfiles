{ config, pkgs, ... }:

{
  imports = [ 
    ./hyprland.nix
  ];

  home.username = "omori";
  home.homeDirectory = "/home/omori";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Terminal utilities
    alacritty
    htop
    wget
    curl
    git
    #neovim
    neofetch
    ripgrep
    fd
    fzf
    tmux
    tree
    unzip
    zip
    jq
    
    # Development tools
    gnumake
    gcc
    gdb
    
    # Browsers and apps
    # firefox
    vscode
    
    # Communication
    discord
  ];

  # Firefox configuration
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "browser.search.region" = "VN";
        "browser.search.isUS" = false;
      };
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "XIVIXMMI";
    userEmail = "lethaikhoinguyen@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Terminal configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake .#thinkpad-x270";
      upgrade = "nix flake update && sudo nixos-rebuild switch --flake .#thinkpad-x270";
    };
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Allow Home Manager to manage itself
  programs.home-manager.enable = true;

  # Hyprland
  wayland.windowManager.hyprland.enable = true;

  programs.waybar = {
    enable = true;
    # optional: set the package to waybar-hyprland
    package = pkgs.waybar;
  };

  # Let Home Manager install and manage fonts
  fonts.fontconfig.enable = true;
}
