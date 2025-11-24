#!/bin/bash

# on start of a new terminal/login, not start of a new shell

. ~/.bashrc
. ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

