unbind-key -n C-a
set -g prefix ^A
set -g prefix2 ^A
bind a send-prefix

bind-key -n C-F2 display-panes \; split-window -h -c '#{pane_current_path}'
bind-key -n S-F2 display-panes \; split-window -v -c '#{pane_current_path}'
