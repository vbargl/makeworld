# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  # Enable experimental features 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];



  # ###########
  # Bootloader

  # Use systemd-boot on EFI systems
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };



  #############
  # Time and region setup

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalization properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";



  ########
  # Users

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    vbargl = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ and virsh
    };
  };



  #############
  # Networking

  networking.hostName = "swordfish";
  networking.wireless.enable = false;



  ###########
  # Services

  # Enable OpenSSH daemon
  services.openssh.enable = true;

  # Enable virtualization support
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
  };



  ##################
  # System packages

  # visit search.nixos.org to find packages
  environment.systemPackages = with pkgs; [
    # 🧰 Basic CLI tools
    fish       # Fish shell
    neovim     # Neovim text editor
    curl       # cURL command line tool
    tmux       # Terminal multiplexer
    git        # Git version control
    lsof       # List open files

    # 🔒 Remote access
    openssh

    # 🖥️ Virtualization stack
    libvirt         # libvirt daemon and CLI tools
    qemu_kvm        # KVM backend for virtualization
    bridge-utils    # Bridge networking for VMs

    # 📈 Monitoring and cluster tools
    gotop           # TUI system monitor
    k9s             # Kubernetes TUI dashboard
    virt-top        # TUI for monitoring VMs
  ];



  ##################
  # Do NOT change this value unless you have manually inspected all the changes with migration guide.
  system.stateVersion = "24.11";
}
