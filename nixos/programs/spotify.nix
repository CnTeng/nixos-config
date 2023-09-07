{
  config,
  lib,
  inputs,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.programs'.spotify;
  spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;

  inherit (config.basics'.colors) flavour;
in {
  options.programs'.spotify.enable = mkEnableOption "Spotify";

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      imports = [inputs.spicetify.homeManagerModule];

      programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes."catppuccin-${toLower flavour}";
        colorScheme = "blue";

        enabledExtensions = with spicePkgs.extensions; [
          copyToClipboard
          keyboardShortcut
          volumePercentage
        ];

        enabledCustomApps = with spicePkgs.apps; [new-releases];
      };
    };
  };
}