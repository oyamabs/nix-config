{ pkgs, lib, config, ... }:

{
	options = {
		gaming.enable = lib.mkEnableOption "Enables Gaming stuff";
	};
	config = lib.mkIf config.gaming.enable {
		programs = {
			gamemode.enable = true;
			gamescope.enable = true;
			steam.enable = true;
			steam.protontricks.enable = true;
		};
		environment.systemPackages = with pkgs; [
			lutris
			steam-run
			dxvk
			gamescope
			mangohud
			heroic
			prismlauncher
		];
	};
}
