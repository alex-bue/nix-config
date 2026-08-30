{
  flake.modules.homeManager.neovim = { lib, pkgs, ... }: {
    home.packages =
      with pkgs;
      [
        curl
        fd
        fzf
        git
        lazygit
        neovim
        ripgrep
        stdenv.cc
        tree-sitter
      ]
      ++ lib.optionals stdenv.hostPlatform.isLinux [ wl-clipboard ];
  };
}
