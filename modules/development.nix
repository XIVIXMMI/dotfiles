{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Java Development
    jdk21
    maven
    gradle
    
    # Node.js Development
    nodejs_20
    yarn
    
    # Python Development
    python3
    python3Packages.pip
    python3Packages.virtualenv
    
    # C++ Development
    gcc
    gdb
    gnumake
    cmake
    clang
    clang-tools
    
    # IDEs and editors
    jetbrains.idea-community
    vscode
    
    # Development tools
    git
    git-lfs
    gh
    
    # Build tools
    autoconf
    pkgconfig
    
    # DevOps tools
    docker-compose
    
    # Spring Boot specific
    spring-boot-cli
  ];

  # Configure Java environment
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  # VSCode extensions
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # For VSCode wayland
  };
}
