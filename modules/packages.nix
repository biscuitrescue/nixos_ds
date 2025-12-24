{ pkgs, inputs, ... }: {


  nixpkgs.overlays = [
    (final: prev: {
     jdk8 = final.openjdk8-bootstrap;
     })
  ];
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    vivaldi
    vivaldi-ffmpeg-codecs
    openvpn
    tailscale
    spotify
    openssl
    pkg-config
    vim
    solc
    gcc
    clang
    discord
    cmake
    obsidian
    nmap
    wget
    unzip
    zip
    glib
    baobab
    bleachbit
    tcpdump
    exfat
    exfatprogs
    killall
    pulseaudio
    ntfs3g
  ];

  programs = {
    command-not-found.enable = true;

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };

    hyprland = {
      enable = true;
      withUWSM = true;
    };

    zsh.enable = true;
    fish.enable = true;
    firefox.enable = true;
    nix-ld.enable = true;
    virt-manager.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
 } 
