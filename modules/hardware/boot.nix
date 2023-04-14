{ config, lib, pkgs, ... }:
with lib;
let cfg = config.hardware'.boot;
in {
  options.hardware'.boot.enable = mkEnableOption "systemd-boot";

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    boot.plymouth = {
      enable = true;
      themePackages = [ pkgs.catppuccin-plymouth ];
      theme = "catppuccin-macchiato";
    };
  };
}
