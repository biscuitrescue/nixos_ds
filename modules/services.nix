{ pkgs, ... }: {
  systemd.services.turn-on-speakers = {
    description = "turn on using i2c";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];
    serviceConfig = {
        User = "root";
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c \"${./2pa-byps.sh} | ${pkgs.util-linux}/bin/logger\"";
    };
    wantedBy = [ "multi-user.target" "sleep.target" ];
  };

  services = {
    logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
    gvfs.enable = true;
    # samba.enable = true;
    dbus.enable = true;

    # emacs = {
    #   enable = true;
    #   package = pkgs.emacs;
    # };
    blueman.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    xserver.windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
    };

    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    printing.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig.pipewire."99-amp" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 2048;
        };
      };
    };
  };
  }
