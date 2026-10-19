{
  pkgs,
  lib,
  config,
  ...
}: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.departure-mono
    ubuntu-sans
    cm_unicode
    corefonts
    unifont
  ];
}
