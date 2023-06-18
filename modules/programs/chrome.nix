{ config, lib, pkgs, user, ... }:
with lib;
let cfg = config.programs'.chrome;
in {
  options.programs'.chrome.enable = mkEnableOption "Chrome";

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.chromium = {
        enable = true;
        package = pkgs.google-chrome;
      };
    };
  };
}
