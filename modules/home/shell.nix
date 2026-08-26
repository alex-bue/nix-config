{
  config,
  lib,
  pkgs,
  ...
}:
let
  shellAliases = {
    v = "nvim";
    vim = "nvim";
    vimdiff = "nvim -d";

    cp = "cp -iv";
    mv = "mv -iv";
    rm = "rm -iv";
    mkdir = "mkdir -pv";

    ls = "eza --git --icons=auto";
    la = "eza -a --git --icons=auto";
    ll = "eza -la --git --icons=auto";
    tree = "eza --tree --icons=auto";

    d = "chezmoi cd";
    ca = "chezmoi apply";
    ce = "chezmoi edit";

    ta = "tmux attach";
    td = "tmux detach";
    lg = "lazygit";

    ga = "git add";
    gaa = "git add --all";
    gau = "git add --update";
    gb = "git branch";
    gc = "git commit -v";
    gca = "git commit -v -a";
    gcam = "git commit -a -m";
    gcmsg = "git commit -m";
    gcf = "git config --list";
    gco = "git checkout";
    gsw = "git switch";
    gd = "git diff";
    gf = "git fetch";
    gp = "git push";
    gpom = "git push origin main";
    gpl = "git pull";
    gr = "git remote";
    grs = "git remote show";
    gst = "git status";
    glog = "git log --oneline --decorate --graph";
    glol = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
    glols = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
  };

  brewShellEnv = lib.optionalString pkgs.stdenv.isDarwin ''
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  '';
in
{
  home = {
    packages = [ pkgs.zsh-completions ];
    sessionPath = [
      "$HOME/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NVIM_APPNAME = "lazyvim";
      FZF_DEFAULT_OPTS = "--height=45% --layout=reverse --border --cycle --preview-window=right,55%";
      FZF_CTRL_R_OPTS = "--sort --exact";
      FZF_ALT_C_OPTS = "--preview='eza -la --color=always {} 2>/dev/null || ls -la {}'";
      FZF_DEFAULT_COMMAND = "fd --type f --follow --exclude .git";
    };
  };

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      inherit shellAliases;
      profileExtra = brewShellEnv;
      bashrcExtra = ''
        if [[ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
          source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        fi
      '';
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
      settings = builtins.fromTOML (builtins.readFile ./files/starship.toml);
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      dotDir = config.home.homeDirectory;
      inherit shellAliases;
      profileExtra = brewShellEnv;
      completionInit = ''
        mkdir -p "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
        autoload -Uz compinit
        compinit -d "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
      '';
      history = {
        path = "${config.home.homeDirectory}/.zsh_history";
        size = 5000;
        save = 5000;
        append = true;
        share = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreAllDups = true;
        findNoDups = true;
        saveNoDups = true;
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      initContent = lib.mkMerge [
        (lib.mkOrder 500 ''
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
        '')
        (lib.mkOrder 850 ''
          function zvm_after_init() {
            bindkey -M viins '^R' fzf-history-widget
            bindkey -M vicmd '^R' fzf-history-widget
            bindkey -M viins '^Y' autosuggest-accept
            bindkey -M vicmd '^Y' autosuggest-accept
          }
        '')
        (lib.mkOrder 1000 ''
          _comp_options+=(globdots)
          zstyle ':completion:*' menu no
          zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
          zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

          function zi() {
            local dir
            dir="$(zoxide query -l | fzf --prompt='zoxide> ' --tac --no-sort --exact)" || return
            builtin cd -- "$dir" || return
          }
        '')
        (lib.mkOrder 1300 ''
          [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
        '')
      ];
    };
  };
}
