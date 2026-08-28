##### Copy mode
set -g mode-style "bg=#{@sel_bg},fg=default"

##### Status line – left
set -g status-left-length 100
set -g status-left ""

# session name
set -ga status-left "#{?client_prefix,#{#[bg=#{@accent},fg=#{@bg1},bold]  #S #[nobold]},#{#[bg=default,fg=#{@accent2}]  #S }}"

# command
set -ga status-left "#[bg=default,fg=#{@fg}]  #{pane_current_command} "

# path
# set -ga status-left "#[bg=default,fg=#{@fg}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "

# zoom indicator
set -ga status-left "#[bg=default,fg=#{@warn}]#{?window_zoomed_flag, 󰊓 zoom ,}"

##### Status line – right
set -g status-right-length 100
set -g status-right ""
# set -ga status-right "#[bg=default,fg=#{@accent2}] 󰭦 %Y-%m-%d 󰅐 %H:%M "
set -ga status-right "#[bg=default,fg=#{@fg}] 󰅐 %H:%M "

##### Status bar layout
set -g status-position top
set -g status-style "bg=default"
set -g status-justify "absolute-centre"

##### Pane borders
setw -g pane-border-status top
setw -g pane-border-format ""
setw -g pane-border-lines single
setw -g pane-active-border-style "fg=#{@accent},bg=default"
setw -g pane-border-style "fg=#{@border},bg=default"

##### Window list
set -wg automatic-rename on
set -g automatic-rename-format "Window"

set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
set -g window-status-style "bg=default,fg=#{@fg}"
set -g window-status-last-style "bg=default,fg=#{@fg}"

set -g window-status-activity-style "bg=#{@err},fg=#{@bg1}"
set -g window-status-bell-style     "bg=#{@err},fg=#{@bg1}"

set -gF window-status-separator "#[bg=default,fg=#{@muted}]"

set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
set -g window-status-current-style "bg=#{@accent},fg=#{@bg1},bold"
