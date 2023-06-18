{ modulesPath, ... }: {
  imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];

  hardware' = {
    stateless.enable = true;
    kernel.modules.bbr = true;
  };

  boot = {
    loader.grub.device = "/dev/sda";

    initrd = {
      availableKernelModules =
        [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
      kernelModules = [ "nvme" ];
    };

    tmp.useTmpfs = true;
  };
}
