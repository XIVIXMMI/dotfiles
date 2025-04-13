{ config, pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker = {
    enable = true;
    
    # Use overlay2 storage driver
    storageDriver = "overlay2";
    
    # Configure Docker daemon options
    extraOptions = "--data-root /var/lib/docker";
  };
  
  # Install Docker related tools
  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker
    ctop           # Container monitoring tool
    docker-gc      # Docker garbage collection
  ];
}
