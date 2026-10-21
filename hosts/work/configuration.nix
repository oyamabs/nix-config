# Edit this configuration file to define what should be installed on your system. Help is available in the 
# configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository: https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules> 
    ../../modules/default.nix
    ../../modules/shell.nix
    ];


  wsl = {
    enable = true;
    defaultUser = "freddy";
    startMenuLaunchers = true;
  };
  services.logind.settings.Login = {
    KillUserProcesses = false;
  };
  tailscale.enable = false; # work machine doesn't allow vpn otherthan theirs (for obvious reasons)

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    curl
    starship
    btop
  ];

  services.dbus.enable = true;
  nixpkgs.config.allowUnfree = true;
  users.users.freddy= {
    createHome = true;
    description = "freddy";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    linger = true;
  };

  wsl.wslConf.network.hostname = "jane";

  programs.zsh.enable = true;
  programs.starship.enable = true;
  # This value determines the NixOS release from which the default settings for stateful data, like file locations and 
  # database versions on your system were taken. It's perfectly fine and recommended to leave this value at the release 
  # version of the first install of this system. Before changing this value read the documentation for this option (e.g. man 
  # configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
