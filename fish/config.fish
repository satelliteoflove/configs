#if status is-interactive
#and not set -q TMUX
#    exec tmux
#end

set PATH /usr/local/bin $HOME/.local/bin $PATH

eval (python3 -m virtualfish auto_activation)

#motd
