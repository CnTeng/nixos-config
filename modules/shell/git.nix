{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.shell'.git;
  inherit (config.users.users.${user}) home;
  inherit (config.basics') colorScheme;
in {
  options.shell'.git.enable = mkEnableOption "git" // {default = true;};

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.git = {
        lfs.enable = true;

        enable = true;
        userName = "CnTeng";
        userEmail = "istengyf@outlook.com";
        delta = {
          enable = true;
          options = {
            dark = true;
            line-numbers = true;
            line-numbers-minus-style = ''"#${colorScheme.red}"'';
            line-numbers-plus-style = ''"#${colorScheme.green}"'';
            syntax-theme = "Catppuccin-macchiato";
          };
        };
      };

      programs.lazygit = {
        enable = true;
        settings = {
          gui.theme = {
            lightTheme = false;
            activeBorderColor = ["#${colorScheme.green}" "bold"];
            inactiveBorderColor = ["#${colorScheme.text}"];
            optionsTextColor = ["#${colorScheme.blue}"];
            selectedLineBgColor = ["#${colorScheme.surface0}"];
            selectedRangeBgColor = ["#${colorScheme.surface0}"];
            cherryPickedCommitBgColor = ["#${colorScheme.teal}"];
            cherryPickedCommitFgColor = ["#${colorScheme.blue}"];
            unstagedChangesColor = ["#${colorScheme.red}"];
          };
          customCommands = [
            {
              key = "C";
              command = "git cz c";
              description = "commit with commitizen";
              context = "files";
              loadingText = "opening commitizen commit tool";
              subprocess = true;
            }
          ];
        };
      };

      programs.ssh.matchBlocks = {
        "github.com" = {
          hostname = "ssh.github.com";
          user = "git";
          port = 443;
          extraOptions.AddKeysToAgent = "yes";
          identityFile = ["${home}/.ssh/id_ed25519_sk_rk_auth@Github"];
        };
      };

      home.packages = with pkgs; [gh commitizen];
    };
  };
}
