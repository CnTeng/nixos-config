{ config, lib, ... }:

with lib;

let
  cfg = config.custom.hardware.kernel;
  inherit (cfg) modules;
in {
  options.custom.hardware.kernel = {
    modules = mapAttrs (_: v: mkEnableOption (mkDoc v)) {
      zswap = "zswap";
      bbr = "BBR module";
    };
  };

  config = mkMerge [
    (mkIf modules.zswap {
      boot = {
        kernelModules = [ "zstd" "zsfold" ];
        kernelParams = [ "zswap.enabled=1" "zswap.max_pool_percent=25" ];
        postBootCommands = ''
          echo zstd > /sys/module/zswap/parameters/compressor
          echo z3fold > /sys/module/zswap/parameters/zpool
        '';
      };
    })
    (mkIf modules.bbr {
      boot = {
        kernelModules = [ "tcp_bbr" ];
        kernel.sysctl = {
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.core.default_qdisc" = "cake";
        };
      };
    })
  ];
}