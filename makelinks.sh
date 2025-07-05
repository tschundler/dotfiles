#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
BASEDIR=$(pwd)

link_recurse() {
    local DEST SRC n DEST_NAME
    DEST=${*: -1:1}
    n=${#*}

    # shell array voodoo... shouldn't it be n-1?
    for SRC in ${*:1:n-1}; do
    	DEST_NAME=$(basename "$SRC")
        if [ -d "$SRC" ]; then
            echo $SRC is DIR
            mkdir -p "$DEST/$DEST_NAME"
            link_recurse "$SRC/*" "$DEST/$DEST_NAME"
        else
            echo Linking $SRC to $DEST
            ln -sf "$SRC" "$DEST/$DEST_NAME"
        fi
    done
}

# home dotfiles
link_recurse $(find $BASEDIR -maxdepth 1 -name ".gitconfig" -or -name ".*" -and -not -name ".git*" -and -not -name ".DS_Store" -and -not -name "." -and -not -name ".vim" -and -not -name ".jj") $HOME

if [ -d ${HOME}/.config/sublime-text-3/Packages/User ]; then
    # UN*X
    SUBLIME_DEST="${HOME}/.config/sublime-text-3/Packages"
else
    # OSX
    SUBLIME_DEST="${HOME}/Library/Application Support/Sublime Text 3/Packages"
fi
link_recurse "$BASEDIR/sublime/User" "$SUBLIME_DEST"

if [ -d ${HOME}/.config/Code/User ]; then
    # UN*X
    CODE_DEST="${HOME}/.config/Code"
else
    # OSX
    CODE_DEST="${HOME}/Library/Application Support/Code"
fi
link_recurse "${BASEDIR}/vscode/User" "${CODE_DEST}"

# utility scripts
link_recurse "$BASEDIR/bin" "${HOME}"

# vim
mkdir -p "${HOME}/.vim"
link_recurse ${BASEDIR}/.vim/autoload "${HOME}/.vim"
ln -sf ${BASEDIR}/.vim/bundle "${HOME}/.vim/"

#OSX Config
if [ -d ${HOME}/Library ]; then
   link_recurse "$BASEDIR/Library" "${HOME}"
fi

#GDB
ln -sf "${BASEDIR}/gdb/.gdbinit" "${HOME}"

