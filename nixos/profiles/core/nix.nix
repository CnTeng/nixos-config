{
  config,
  data,
  lib,
  ...
}:
let
  inherit (config.networking) hostName;

  hosts = lib.filterAttrs (n: v: n != hostName && v.nixbuild) data.hosts;

  machineSecrets = lib.concatMapAttrs (host: _: {
    "nixbuild/${host}_private_key".key = "hosts/${host}/nixbuild_key_pair/private_key";
  }) hosts;

  mkBuildMachine = host: hostData: {
    hostName = host;
    protocol = "ssh-ng";
    inherit (hostData) system;
    sshUser = "nixbuild";
    sshKey = config.sops.secrets."nixbuild/${host}_private_key".path;
    maxJobs = 5;
    supportedFeatures = [
      "big-parallel"
      "kvm"
      "nixos-test"
    ];
  };

  buildMachines = lib.mapAttrsToList mkBuildMachine hosts;
in
{
  nix.settings = {
    auto-allocate-uids = true;
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = [
      "auto-allocate-uids"
      "ca-derivations"
      "cgroups"
      "flakes"
      "nix-command"
    ];

    substituters = [
      "https://cache.garnix.io"
      "https://cosmic.cachix.org"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
    use-cgroups = true;
    use-xdg-base-directories = true;
  };

  nix = {
    inherit buildMachines;
    distributedBuilds = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  sops.secrets = machineSecrets;
}
