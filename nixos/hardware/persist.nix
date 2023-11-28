{ config, inputs, lib, user, ... }:
with lib;
let cfg = config.hardware'.persist;
in {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.hardware'.persist.enable = mkEnableOption "persistent state";

  config = mkIf cfg.enable {
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/lib"
        "/etc/nix"
        {
          directory = "/etc/secureboot";
          user = "root";
          group = "root";
          mode = "u=rwx,g=rx,o=rx";
        }
      ];
      files = [ "/etc/machine-id" ];
      users.${user}.directories =
        [ "Projects" ".cache" ".local" ".mozilla" ".ssh" ".config" ];
    };
  };
}
