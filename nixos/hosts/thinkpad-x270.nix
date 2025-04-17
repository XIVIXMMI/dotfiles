{ config, pkgs, inputs, ... }:

{
  imports = [
    ../hardware/x270.nix
    ../modules/system.nix
    ../modules/gnome.nix
    ../modules/hyprland/default.nix
    ../modules/development.nix
    ../modules/docker.nix
  ];

  # Hardware specific configuration
  boot.kernelModules = [ "thinkpad_acpi" ];
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
  '';
  
  networking.hostName = "thinkpad-x270";
  networking.networkmanager.enable = true;

  # CPU specific optimizations for i5-6300U
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
  
  # Enable power management features for laptop
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      PCIE_ASPM_ON_BAT = "powersave";
    };
  };

  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  # Setup thinkfan
  services.thinkfan = {
    enable = true;
    levels = [
      [0 0 55]    # fan level 0 if temp below 55°C
      [1 50 65]   # level 1 between 50–65°C
      [2 60 75]   # level 2 between 60–75°C
      [3 70 85]   # and so on...
      [7 80 32767]
    ];
  };

  # Enable fingerprint reader if available
  services.fprintd.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # User account
  users.users.omori = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
    shell = pkgs.bash;
  };

  #Hyprland
  services.displayManager.defaultSession = "hyprland";
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # System settings
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
