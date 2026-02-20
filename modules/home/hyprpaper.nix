{ ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      preload = [
        "/home/cafo/git/wallpapers/chaos_rose.png"
      ];
    };

    extraConfig = ''
      wallpaper {
        monitor = eDP-1
        path = /home/cafo/git/wallpapers/chaos_rose.png
      }

      wallpaper {
        monitor = eDP-2
        path = /home/cafo/git/wallpapers/chaos_rose.png
      }
    '';
  };
}
