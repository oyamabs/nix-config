{ config, pkgs, ... }:

{
	home.username = "freddy";
	home.homeDirectory = "/home/freddy";
	home.stateVersion = "26.05";
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
# 1. Configuration GTK (GTK 2, 3 et 4)
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # 2. Configuration Qt
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # 3. Préférence globale FreeDesktop / XDG (navigateurs, Electron, Flatpak)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  # 4. Variables d'environnement pour forcer les toolkits récalcitrants
  home.sessionVariables = {
    # Force le mode sombre pour GTK
    GTK_THEME = "Adwaita-dark";
    # Indique aux applis Qt d'utiliser le style configuré
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
}
