{ config, lib, pkgs, user, ... }:

with lib;

let cfg = config.custom.programs.pycharm;
in {
  options.custom.programs.pycharm = {
    enable = mkEnableOption "jetbrains pycharm";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = with pkgs; [ jetbrains.pycharm-community ];
    };
  };
}
