# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/users.nix
      ./modules/services.nix
      ./modules/keyd.nix
      ./modules/packages.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.neovim.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "cafo" = import ./modules/home/home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;
  security.rtkit.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
