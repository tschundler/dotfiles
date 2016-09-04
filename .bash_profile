#!/bin/bash

# on start of a new terminal/login, not start of a new shell

. ~/.bashrc
. ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by Anaconda3 4.0.0 installer
export PATH="/Users/ted/anaconda3/bin:$PATH"
