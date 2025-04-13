{ config, pkgs, ... }:

{
  imports = [
    ../modules/system.nix
    ../modules/gnome.nix
    ../modules/development.nix
    ../modules/docker.nix
  ];

  # Hardware specific configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "thinkpad-x270";
  networking.networkmanager.enable = true;

  # CPU specific optimizations for i5-6300U
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "powersave";
  
  # Enable power management features for laptop
  services.tlp.enable = true;
  services.thermald.enable = true;

  # Enable fingerprint reader if available
  services.fprintd.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # User account
  users.users.omori = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.bash;
  };

  # System settings
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
