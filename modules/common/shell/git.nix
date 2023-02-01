{ config, pkgs, user, ... }:

let
  homeDirectory = config.home-manager.users.${user}.home.homeDirectory;
in
{
  home-manager.users.${user} = {
    programs.ssh.matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        user = "git";
        port = 443;
        extraOptions = {
          AddKeysToAgent = "yes";
        };
        identityFile = [
          "${homeDirectory}/.ssh/id_ed25519_sk_rk_auth@Github"
        ];
      };
    };

    programs.git = {
      enable = true;
      userName = "CnTeng";
      userEmail = "istengyf@outlook.com";
    };

    home.packages = with pkgs;[
      gh
      commitizen
    ];
  };
}
