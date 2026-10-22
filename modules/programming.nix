{pkgs, ...}: {
  documentation.dev.enable = true;
  environment.systemPackages = with pkgs; [
    (buildFHSEnv {
      name = "fhs-dev";
      targetPkgs = pkgs: with pkgs; [
        clang-tools
        clang
        glibc.dev
        gnumake
        neovim
      ];
      runScript = "bash";
    })
  ];

}
