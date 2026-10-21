{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    tailscale.enable = lib.mkEnableOption "Enables tailscale";
  };
  config = lib.mkIf config.tailscale.enable {
    services.tailscale.enable = lib.mkDefault true;
  };
}
