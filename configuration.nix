{ config, pkgs, ... }:

{
  # ==========================================
  # 1. HARDWARE & IMPORTS
  # ==========================================
  imports = [
    ./hardware-configuration.nix
  ];

  # ==========================================
  # 2. NIX CORE SETTINGS
  # ==========================================
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;
  
  # DO NOT CHANGE THIS unless you read the NixOS release notes.
  system.stateVersion = "26.05"; 

  # ==========================================
  # 3. BOOTLOADER & KERNEL
  # ==========================================
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # Load AMD GPU drivers early in the boot process
  boot.initrd.kernelModules = [ "amdgpu" ];

  # ==========================================
  # 4. NETWORKING & TIME
  # ==========================================
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  # ==========================================
  # 5. USER ACCOUNTS
  # ==========================================
  users.users."lmtot27" = {
    isNormalUser = true;
    description = "Le Minh Tuan";
    # 'wheel' group allows the user to execute commands with sudo
    extraGroups = [ "networkmanager" "wheel" ]; 
  };

  # ==========================================
  # 6. SYSTEM PACKAGES
  # ==========================================
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
}
