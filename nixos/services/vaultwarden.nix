{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services'.vaultwarden;
in {
  options.services'.vaultwarden.enable = mkEnableOption "Vaultwarden";

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [587 3222 8222];

    services = {
      vaultwarden = {
        enable = true;
        config = {
          # Domain settings
          DOMAIN = "https://pwd.snakepi.xyz";
          SIGNUPS_ALLOWED = true;

          # Rocket specific settings
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
          ROCKET_LOG = "critical";

          # Enables websocket notifications
          WEBSOCKET_ENABLED = true;

          # Controls the WebSocket server address and port
          WEBSOCKET_ADDRESS = "127.0.0.1";
          WEBSOCKET_PORT = 3222;
        };
        environmentFile = config.sops.secrets.vaultwarden.path;
      };

      caddy.virtualHosts."pwd.snakepi.xyz" = {
        logFormat = "output stdout";
        extraConfig = ''
          import ${config.sops.secrets.cloudflare.path}

          bind

          encode gzip

          header / {
            Strict-Transport-Security "max-age=31536000;"
            X-XSS-Protection "1; mode=block"
            X-Frame-Options "DENY"
            X-Robots-Tag "none"
            -Server
          }

          reverse_proxy /notifications/hub/negotiate 127.0.0.1:8222
          reverse_proxy /notifications/hub 127.0.0.1:3222
          reverse_proxy 127.0.0.1:8222 {
            header_up X-Real-IP {remote_host}
          }
        '';
      };
    };

    sops.secrets.vaultwarden = {
      path = "/var/lib/vaultwarden.env";
      owner = "vaultwarden";
      sopsFile = ./secrets.yaml;
    };
  };
}
