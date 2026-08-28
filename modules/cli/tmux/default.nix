{ ... }:
{
  flake.modules.homeManager.tmux =
    { pkgs, ... }:
    let
      tmuxSessionPicker = pkgs.writeShellApplication {
        name = "tmux-session-picker";
        runtimeInputs = with pkgs; [
          fzf
          sesh
          tmux
        ];
        text = ''
          script_path="$0"

          if [[ ! -t 0 || ! -t 1 ]]; then
            client_tty="$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -n1 || true)"

            if [[ -n "$client_tty" ]]; then
              if tmux display-popup -t "$client_tty" -w 40% -h 70% -E "$script_path" 2>/dev/null; then
                exit 0
              fi
            fi

            if [[ "$(uname -s)" == "Darwin" ]]; then
              exec open -na Ghostty.app --args --command="$script_path"
            fi

            echo "tmux-session-picker requires an interactive terminal" >&2
            exit 1
          fi

          choice="$(
            sesh list -t | fzf \
              --ansi \
              --prompt='Sessions > ' \
              --height=100% \
              --margin=0,0 \
              --padding=1,2 \
              --layout=reverse \
              --border=none \
              --info=inline \
              --bind 'ctrl-j:down,ctrl-k:up,ctrl-n:down,ctrl-p:up,alt-j:down,alt-k:up' \
              --bind 'ctrl-s:change-prompt(Sessions > )+reload(sesh list -t)' \
              --bind 'ctrl-f:change-prompt(Create session from zoxide > )+reload(sesh list -z -d)' \
              --bind "ctrl-x:execute-silent(sh -c 's=\"{}\"; [ -n \"\$s\" ] && tmux kill-session -t \"\$s\"')+reload(sesh list -t)" ||
              true
          )"

          [[ -n "$choice" ]] || exit 0
          exec sesh connect "$choice"
        '';
      };
    in
    {
      home.packages = [
        pkgs.sesh
        tmuxSessionPicker
      ];

      programs.tmux = {
        enable = true;
        baseIndex = 1;
        focusEvents = true;
        historyLimit = 15000;
        keyMode = "vi";
        mouse = true;
        prefix = "C-Space";
        terminal = "tmux-256color";
        plugins = with pkgs; [
          tmuxPlugins.sensible
          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = "set -g @resurrect-strategy-nvim 'session'";
          }
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = "set -g @continuum-restore 'on'";
          }
          {
            plugin = tmuxPlugins.better-mouse-mode;
            extraConfig = ''set -g @scroll-speed-num-lines-per-scroll "1"'';
          }
        ];
        extraConfig = ''
          set -s repeat-time 1000
          set-option -sa terminal-overrides ",xterm-256color:RGB"
          set -g set-clipboard on
          set -g detach-on-destroy off
          set -g renumber-windows on

          bind -r C-n next-window
          bind -r C-p previous-window
          bind -r l next-window
          bind -r h previous-window

          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          bind V choose-tree -F '#{E:@custom_choose_tree_format}' -Z 'join-pane -h -s "%%"'
          bind S choose-tree -F '#{E:@custom_choose_tree_format}' -Z 'join-pane -v -s "%%"'

          bind -r -T prefix C-j resize-pane -D 2
          bind -r -T prefix C-k resize-pane -U 2
          bind -r -T prefix C-h resize-pane -L 2
          bind -r -T prefix C-l resize-pane -R 2

          bind -T copy-mode-vi v send-keys -X begin-selection
          bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          run-shell ${pkgs.vimPlugins.smart-splits-nvim}/smart-splits.tmux
          source-file ~/.config/tmux/palettes/everforest-dark-medium.tmux
          source-file ~/.config/tmux/themes/minimal.tmux
        '';
      };

      xdg.configFile = {
        "tmux/palettes/everforest-dark-medium.tmux".source = ./palettes/everforest-dark-medium.tmux;
        "tmux/themes/minimal.tmux".source = ./themes/minimal.tmux;
      };
    };
}
