{ config, lib, ... }:
with lib;
let
  inherit (config.services'.tuic) server client;
  port = 1080;
in
{
  options.services'.tuic = {
    server.enable = mkEnableOption' { };
    client.enable = mkEnableOption' { };
  };

  config = mkIf (server.enable || client.enable) {
    networking.firewall.allowedUDPPorts = [ port ];

    sops.secrets = {
      cf-dns01-token = mkIf server.enable {
        key = "outputs/cf_api_token/value";
        sopsFile = config.sops-file.infra;
        restartUnits = [ "sing-box.service" ];
      };

      tuic-ip = mkIf client.enable {
        key = "outputs/hosts/value/lssg/ipv4";
        sopsFile = config.sops-file.infra;
        restartUnits = [ "sing-box.service" ];
      };

      "tuic/uuid" = {
        sopsFile = ./secrets.yaml;
        restartUnits = [ "sing-box.service" ];
      };

      "tuic/pass" = {
        sopsFile = ./secrets.yaml;
        restartUnits = [ "sing-box.service" ];
      };
    };

    services.sing-box = {
      enable = true;
      settings =
        let
          serverConfig = {
            log.level = "info";
            inbounds = [
              {
                type = "tuic";
                listen = "::";
                listen_port = port;
                users = [
                  {
                    uuid._secret = config.sops.secrets."tuic/uuid".path;
                    password._secret = config.sops.secrets."tuic/pass".path;
                  }
                ];
                congestion_control = "bbr";
                tls = {
                  enabled = true;
                  server_name = "tuic.snakepi.xyz";
                  acme = {
                    domain = "tuic.snakepi.xyz";
                    email = "isyufei.teng@gmail.com";
                    dns01_challenge = {
                      provider = "cloudflare";
                      api_token._secret = config.sops.secrets.cf-dns01-token.path;
                    };
                  };
                };
              }
            ];
          };

          clientConfig = {
            log.level = "trace";
            dns = {
              servers = [
                {
                  tag = "cloudflare";
                  address = "https://1.1.1.1/dns-query";
                  address_resolver = "local";
                  detour = "proxy";
                }
                {
                  tag = "local";
                  address = "223.5.5.5";
                  detour = "direct";
                }
              ];
              rules = [
                {
                  outbound = "any";
                  server = "local";
                }
              ];
            };
            inbounds = [
              {
                type = "tun";
                interface_name = "tun0";
                inet4_address = "172.19.0.1/30";
                inet6_address = "fdfe:dcba:9876::1/126";
                auto_route = true;
                strict_route = false;
              }
            ];
            outbounds = [
              {
                type = "tuic";
                server._secret = config.sops.secrets.tuic-ip.path;
                server_port = port;
                uuid._secret = config.sops.secrets."tuic/uuid".path;
                password._secret = config.sops.secrets."tuic/pass".path;
                congestion_control = "bbr";
                network = "tcp";
                tls = {
                  enabled = true;
                  server_name = "tuic.snakepi.xyz";
                };
                tag = "proxy";
              }
              # {
              #   type = "socks";
              #   server = "127.0.0.1";
              #   server_port = 1081;
              #   tag = "proxy";
              # }
              {
                type = "direct";
                tag = "direct";
              }
              {
                type = "dns";
                tag = "dns-out";
              }
            ];
            route = {
              rules = [
                {
                  port = [ 53 ];
                  outbound = "dns-out";
                }
                {
                  port = [ 1081 ];
                  outbound = "direct";
                }
                {
                  protocol = "dns";
                  outbound = "dns-out";
                }
                {
                  ip_is_private = true;
                  outbound = "direct";
                }
                {
                  rule_set = "geoip-cn";
                  outbound = "direct";
                }
                {
                  process_name = [ "ssh" ];
                  outbound = "direct";
                }
              ];
              rule_set = [
                {
                  tag = "geosite-cn";
                  type = "remote";
                  format = "binary";
                  url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs";
                }
                {
                  tag = "geoip-cn";
                  type = "remote";
                  format = "binary";
                  url = "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs";
                }
              ];
              auto_detect_interface = true;
            };
          };
        in
        optionalAttrs server.enable serverConfig // optionalAttrs client.enable clientConfig;
    };

    boot.kernel.sysctl = {
      "net.ipv4.conf.all.forwarding" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    networking.firewall.trustedInterfaces = [ "tun0" ];
  };
}
