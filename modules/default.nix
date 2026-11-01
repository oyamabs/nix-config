{
  nixpkgs,
  lib,
  config,
  pkgs,
  ...
}: {
  # modules
  imports = [
    ./tailscale.nix
    ./fonts.nix
    ./terminal.nix
    ./programming.nix
  ];
  # language and timezone
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  xdg.mime.enable = true;

  # Keyboard (using US international with dead keys on AltGr)
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glib
    nss
    nspr
    atk
    cairo
    gtk3
    pango
    gdk-pixbuf
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb
    libxkbcommon
    mesa
    libgbm
    alsa-lib
    cups
    dbus
    expat
  ];
  # tailscale.enable = true;
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
