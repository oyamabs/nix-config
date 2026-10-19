{ config, pkgs, ... }:

{
	home.username = "freddy";
	home.homeDirectory = "/home/freddy";
	home.stateVersion = "26.05";
	programs.bash = {
		enable = true;
	};
	programs.git = {
		enable = true;
	 	lfs.enable = true;
		settings = {
			user.name = "oyamabs";
			user.email = "tchampio@student.42lehavre.fr";
		};
	};
	home.packages = with pkgs; [
		discord
	];
	home.file.".wallpaper.png".source = ./wallpaper.png;
	# home.file.".config/sway".source = ../../config/sway;
	# home.file.".config/hypr".source = ../../config/hypr;
	home.file.".config/nvim" = {
		source = ../../config/nvim;
		recursive = true;
	};
}
