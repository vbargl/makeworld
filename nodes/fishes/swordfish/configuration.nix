# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
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

  # firewall configuration
  networking.firewall.allowedTCPPorts = [ 2224 ]; # pcsd
  networking.firewall.allowedUDPPorts = [ 5405 ]; # corosync



  ###########
  # Services

  # Enable OpenSSH daemon
  services.openssh.enable = true;

  services.pacemaker.enable = true;
  services.corosync.enable = true;



  ##################
  # System packages

  # visit search.nixos.org to find packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    gotop
    tmux
    fish
    openssh
    git
    qemu_kvm
    virt-manager
    libvirt
    bridge-utils
    spice-gtk
    dmidecode
    lsof
    pcs
    corosync
    pacemaker
  ];

  # Enable virtualization support
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
  };



  ##################
  # Static files

  environment.etc."corosync/corosync.conf".text = builtins.readFile ./corosync/corosync.conf;



  ##################
  # Do NOT change this value unless you have manually inspected all the changes with migration guide.
  system.stateVersion = "24.11";
}
