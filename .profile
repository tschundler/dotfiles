# OSX Wants me to switch to ZSH
export BASH_SILENCE_DEPRECATION_WARNING=1

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "/opt/local/bin" ]; then
# MacPorts Installer addition on 2013-11-14_at_17:20:09: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
fi

# virtualenv wrapper
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME="${HOME}/.virtualenvs"
    source "/usr/local/bin/virtualenvwrapper.sh"
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
