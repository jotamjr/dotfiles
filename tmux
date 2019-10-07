# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

set -g default-terminal "tmux-256color"
#set -g default-terminal "screen-256color"
#run-shell "powerline-daemon -q"
#source "~/hypercube/tools/powerline/powerline/bindings/tmux/powerline.conf

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Enable mouse mode (tmux 2.1 and above)
set -g mouse on

# Sue vim shortcuts
setw -g mode-keys vi

set -g set-clipboard off

# Copy outside tmux buffer
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"
