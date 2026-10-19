# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/grub.nix
    ../../modules/default.nix
    ../../modules/gaming.nix
    ../../modules/shell.nix
  ];
  gaming.enable = true;

  # Enable NVidia proprietary drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Encrypting the disk
  boot.initrd.luks.devices."luks-5f8b540d-c820-4abc-a457-23cdff3e6900".device = "/dev/disk/by-uuid/5f8b540d-c820-4abc-a457-23cdff3e6900";
  networking.hostName = "belle"; # Define your hostname.

  # Flakes
  networking.networkmanager.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."freddy" = {
    isNormalUser = true;
    description = "freddy";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    waybar
    kitty
    mako
    uwsm
  ];

  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    extraOptions = ["--unsupported-gpu"];
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.stateVersion = "26.05";
}
