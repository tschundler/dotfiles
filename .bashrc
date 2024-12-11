#!/bin/bash

##### Start!


##### Early operations

# homebrew
if [ $(uname) = Darwin ]; then
  if [ -d $HOME/homebrew ]; then
    export PATH=$HOME/homebrew/bin:$PATH
    export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
  fi
fi

######################## Ubuntu defaults

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-*color*) color_prompt=yes;;
    screen-*color*) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias tmuxd='tmux new-session -A -s default'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# rustup
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# espup
if [ -f "$HOME/export-esp.sh" ]; then
  .  "$HOME/export-esp.sh" 
fi

################# Ted's stuff

if [ -x /snap/bin ]; then
  export PATH=/snap/bin:${PATH}
fi

# bun
if [ -x "${HOME}/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH=$BUN_INSTALL/bin:$PATH
fi

# go
if [ -x "${HOME}/go/bin" ]; then
  export GOPATH="${HOME}/go"
  export PATH="${PATH}:${HOME}/go/bin"
fi

if [ -x /usr/share/powerline ]; then
  alias powerline="source /usr/share/powerline/bindings/bash/powerline.sh"
fi

alias terminal-notifier=/Applications/Utilities/terminal-notifier.app/Contents/MacOS/terminal-notifier

#tcsh style arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\t":menu-complete'

#Autocomplete helpers
#. $HOME/sources/django-svn/extras/django_bash_completion

#Kate
kopen() {
    KATE=$(qdbus "org.kde.kate*")
    DIR=$(pwd)
    for DOC in "$@"; do
        cd "$DIR"
        cd "$(dirname "$DOC")"
        FILE=$(pwd)/$(basename "$DOC")
        echo $FILE
        if [ -f "$FILE" ]; then
            qdbus $KATE /MainApplication org.kde.Kate.Application.openUrl "$FILE" utf-8
        else
            echo Can\'t find $FILE
        fi
    done
    cd "$DIR"
}

#PIP

if [ -x $HOME/.local/bin ]; then
    export PATH="${PATH}:${HOME}/.local/bin"
fi

#Sublime
[ -x /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/bin/subl

if [ -x $HOME/.rvm/bin ]; then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

#PlatformIO
if [ -x $HOME/.platformio/penv/bin ]; then
	export PATH="${PATH}:${HOME}/.platformio/penv/bin"
fi

# VSCode
if [ -x "/Applications/Visual Studio Code.app" ]; then
	export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

#Local Python
if [ -x $HOME/.local/bin ]; then
	export PATH="${PATH}:${HOME}/.local/bin"
fi

if [ -x /usr/bin/ksshaskpass ]; then
	export SSH_ASKPASS=/usr/bin/ksshaskpass
	if [ -z "${SSH_AUTH_SOCK}" -a -n "${XDG_RUNTIME_DIR}" ]; then
		export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
	fi
fi

if [ -f ${HOME}/.config/broot/launcher/bash/br ]; then
	source ${HOME}/.config/broot/launcher/bash/br
fi

if [ ! -z $(which zoxide) ]; then
  eval "$(zoxide init bash)"
fi

if [ -f "${HOME}/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
CHOME=${HOME}/anaconda3
if [ -x ${HOME}/opt/anaconda3 ]; then
  CHOME=${HOME}/opt/anaconda3
fi
if [ -x ${HOME}/mambaforge ]; then
  CHOME=${HOME}/mambaforge
fi

__conda_setup="$('${CHOME}/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${CHOME}/etc/profile.d/conda.sh" ]; then
        . "${CHOME}/etc/profile.d/conda.sh"
    fi
fi

if [ -f "${CHOME}/etc/profile.d/mamba.sh" ]; then
    . "${CHOME}/etc/profile.d/mamba.sh"
fi

# For some reason this isn't usually set...
if [ -x "${CHOME}/bin" ]; then
    export PATH="$PATH:${CHOME}/bin"
fi

unset __conda_setup
# <<< conda initialize <<<

# pnpm
export PNPM_HOME="/home/ted/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#### End Content

#### EOF

