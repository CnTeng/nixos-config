{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.programs'.wps;
in {
  options.programs'.wps.enable = mkEnableOption "wps";

  config = mkIf cfg.enable {
    fonts.fonts = with pkgs; [ttf-ms-win10 ttf-wps-fonts];

    home-manager.users.${user} = {
      home.packages = [pkgs.wpsoffice-cn];
    };
  };
}