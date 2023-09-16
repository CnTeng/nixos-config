{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.shell'.fish;
  inherit (inputs.themes) fishCat;
in {
  options.shell'.fish.enable = mkEnableOption "fish" // {default = true;};

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      useBabelfish = true;
      shellInit = ''
        set -U fish_greeting
      '';
    };

    users.users.${user}.shell = pkgs.fish;

    home-manager.users.${user} = {
      programs.fish = {
        enable = true;
        plugins = [
          {
            name = "fzf-fish";
            inherit (pkgs.fishPlugins.fzf-fish) src;
          }
        ];
        interactiveShellInit = ''
          fish_config theme choose "Catppuccin Macchiato"
        '';
      };
      xdg.configFile."fish/themes".source = "${fishCat}/themes";
    };
  };
}
