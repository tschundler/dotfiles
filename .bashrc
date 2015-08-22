#!/bin/bash

export PATH=$HOME/bin:$PATH
# Java maven
#export PATH=/Users/tschundler/javaland/apache-maven-3.2.1/bin:$PATH

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
