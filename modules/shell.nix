{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
    };
    histSize = 10000;

    interactiveShellInit = ''
      # Options d'historique
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY

      # Charge les modules de recherche par préfixe
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search

      # Liaison des touches
      bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "$terminfo[kcud1]" down-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search
    '';
  };

  programs.starship = {
    enable = true;
    # Active automatiquement l'intégration dans Zsh
    enableZshIntegration = true;

    # Configuration personnalisée (génère ~/.config/starship.toml)
    settings = {
      add_newline = false;
      format = "$directory$git_branch$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        truncation_length = 3; # Affiche jusqu'à 3 dossiers parents
        truncate_to_repo = false; # Empêche de tronquer à la racine Git si tu veux tout le chemin
        style = "bold cyan"; # Couleur du dossier
        read_only = " 󰌾"; # Icône si le dossier est en lecture seule
        fish_style_pwd_dir_length = 1;
      };

      git_branch = {
        symbol = "🌱 ";
      };
    };
  };
}
