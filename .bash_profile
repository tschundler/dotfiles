#!/bin/bash

# on start of a new terminal/login, not start of a new shell

. ~/.bashrc
. ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by Anaconda3 4.0.0 installer
# export PATH="/Users/ted/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ted/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ted/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ted/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ted/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

