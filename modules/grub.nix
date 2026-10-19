{
  nixpkgs,
  lib,
  config,
  ...
}: {
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev"; # nodev = EFI enabled, if not just replace nodev with the disk NixOS is installed on.
    efiSupport = true;
    efiInstallAsRemovable = false; # EFI stuff, still useful in some situation (like booting in legacy mode)
    useOSProber = true; # Can detect other OSes, useful for dual boots
    memtest86.enable = true; # include a little memtest ELF binary just in case RAM fucks up
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
