{pkgs, ...}: {
  documentation.dev.enable = true;
  environment.systemPackages = with pkgs; [
        clang-tools
        clang
        glibc.dev
        gnumake
        neovim
        nodejs
  ];
}
