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
    boot.kernelModules = [ "i2c-dev" ];

    networking.hostName = "nixos"; # Define your hostname.
        networking.networkmanager.enable = true;

    networking.firewall.trustedInterfaces = [ "virbr0" ];

# Set your time zone.
    time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
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

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                ControllerMode = "bredr"; # Fix frequent Bluetooth audio dropouts
                    Experimental = true;
                FastConnectable = true;
            };
            Policy = {
                AutoEnable = true;
            };
        };
    };

    fonts.packages = [ "${pkgs.fetchFromGitHub {
        owner = "Tecate";
        repo = "bitmap-fonts";
        rev = "5c101c91bf2ed0039aad02f9bf76ddb2018b1f21";
        sha256 = "0s119zln3yrhhscfwkjncj72cr68694643009aam63s2ng4hsmfl";
    }}/bitmap" ];

    fonts.fontconfig.allowBitmaps = true;

    nixpkgs.config.allowUnfree = true;
    security.rtkit.enable = true;
    security.pam.services.i3lock.enable = true;
    system.stateVersion = "25.05"; # Did you read the comment?


nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
