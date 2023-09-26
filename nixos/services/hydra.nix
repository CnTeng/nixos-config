{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services'.hydra;
in {
  options.services'.hydra.enable = mkEnableOption "Hydra";

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [9222];

    services.hydra = {
      enable = true;
      hydraURL = "https://hydra.snakepi.xyz";
      port = 9222;
      notificationSender = "hydra@snakepi.eu.org";
      smtpHost = "smtp.gmail.com";
      useSubstitutes = true;
    };

    systemd.services.hydra-notify = {
      serviceConfig.EnvironmentFile = config.sops.templates.hydra-email.path;
    };

    sops.secrets."hydra/smtp" = {
      owner = "hydra";
      sopsFile = ./secrets.yaml;
      key = "smtp";
    };

    sops.templates.hydra-email = {
      content = ''
        email_sender_transport_sasl_username=jstengyufei
        email_sender_transport_sasl_password=${config.sops.placeholder."hydra/smtp"}
        EMAIL_SENDER_TRANSPORT_port=587
        EMAIL_SENDER_TRANSPORT_ssl=starttls
      '';
      owner = "hydra";
    };

    boot.binfmt.emulatedSystems = ["x86_64-linux"];

    nix.buildMachines = [
      {
        hostName = "localhost";
        systems = ["x86_64-linux" "aarch64-linux"];
        maxJobs = 3;
      }
    ];

    services.caddy.virtualHosts."hydra.snakepi.xyz" = {
      logFormat = "output stdout";
      extraConfig = ''
        import ${config.sops.secrets.cloudflare.path}

        bind

        encode gzip

        reverse_proxy 127.0.0.1:9222
      '';
    };
  };
}
