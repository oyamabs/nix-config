{ nixpkgs, lib, config, ... }:

{
	# modules
	imports = [
		./tailscale.nix
		./fonts.nix
		./terminal.nix
	];
	# language and timezone
	time.timeZone="Europe/Paris";
	i18n.defaultLocale="fr_FR.UTF-8";
	i18n.extraLocaleSettings={
		LC_ADDRESS="fr_FR.UTF-8";
		LC_IDENTIFICATION="fr_FR.UTF-8";
		LC_MEASUREMENT="fr_FR.UTF-8";
		LC_MONETARY="fr_FR.UTF-8";
		LC_NAME="fr_FR.UTF-8";
		LC_NUMERIC="fr_FR.UTF-8";
		LC_PAPER="fr_FR.UTF-8";
		LC_TELEPHONE="fr_FR.UTF-8";
		LC_TIME="fr_FR.UTF-8";
	};

	# Keyboard (using US international with dead keys on AltGr)
	services.xserver.xkb = {
		layout = "us";
		variant = "altgr-intl";
	};
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	tailscale.enable = true;
}
