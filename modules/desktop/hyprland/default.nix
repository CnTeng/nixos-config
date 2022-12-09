{ pkgs, user, ... }:

{
  imports = [
    ../modules/theme.nix
    ../modules/waybar.nix
    ../modules/mako.nix
    ../modules/rofi
    ../modules/swayidle.nix
    ../modules/swaylock.nix
    ../modules/udiskie.nix
  ];

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Customize the recommended environment
  environment = {
    sessionVariables = {
      # GTK
      GDK_DPI_SCALE = "1.25";
      GDK_BACKEND = "wayland,x11";

      # QT
      QT_SCALE_FACTOR = "1.25";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      XCURSOR_SIZE = "32";
      # NIXOS_OZONE_WL = "1"; # Vscode need to run under xwayland to use fcitx5
      XDG_SESSION_DESKTOP = "Hyprland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
    systemPackages = with pkgs;[
      wl-clipboard
    ];
  };

  # Enable trash can for pcmanfm
  services.gvfs.enable = true;

  home-manager.users.${user} = {
    imports = [ ./home.nix ];
  };
}
