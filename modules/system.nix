{ config, pkgs, ... }:

{
  # System-wide packages
  environment.systemPackages = with pkgs; [
    # System utilities
    vim
    wget
    curl
    git
    htop
    neofetch
    
    # Archive tools
    zip
    unzip
    p7zip
    
    # Network tools
    dnsutils
    nmap
    tcpdump
    
    # System monitors
    lm_sensors
    iotop
    powertop
    
    # File managers
    file
    nautilus
  ];

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # OpenSSH
  services.openssh.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # Automatic system upgrades
  system.autoUpgrade = {
    enable = false;  # Set to true if you want automatic upgrades
    allowReboot = false;
  };

  # NTP time synchronization
  services.timesyncd.enable = true;

  # Enable periodic SSD TRIM
  services.fstrim.enable = true;
}
