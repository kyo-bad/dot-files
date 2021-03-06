#!/bin/bash

cd `dirname $0`

echo Tune shell options && {
    set -o errexit
    set -o nounset
    set -o pipefail
}

echo Define Variables && {
    readonly PWD=$(pwd)
}

echo Setup fish && {
    if type fish >/dev/null 2>&1; then
        ln -sf $PWD/.config/fish/config.fish $HOME/.config/fish/config.fish
        if [ ! -d $HOME/.config/fish/functions ]; then
            mkdir -p $HOME/.config/fish/functions
        fi
        if [ ! -d $HOME/.config/fish/conf.d ]; then
            mkdir -p $HOME/.config/fish/conf.d
        fi

        for file in $(find $PWD/.config/fish/functions -maxdepth 1 -type f); do
            ln -sf $PWD/.config/fish/functions/${file##*/} $HOME/.config/fish/functions/${file##*/}
        done

        for file in $(find $PWD/.config/fish/conf.d -maxdepth 1 -type f); do
            ln -sf $PWD/.config/fish/conf.d/${file##*/} $HOME/.config/fish/conf.d/${file##*/}
        done
    else
        echo "fish does not exist in $PATH"
    fi
}

echo Setup tmux && {
    if type tmux >/dev/null 2>&1; then
        ln -sf $PWD/.tmux.conf $HOME/.tmux.conf
    else
        echo "tmux does not exist in $PATH"
    fi
}

echo Setup vim && {
    if type vim >/dev/null 2>&1; then
        ln -sf $PWD/.vimrc $HOME/.vimrc
        ln -sf $PWD/.ideavimrc $HOME/.ideavimrc
        ln -sf $PWD/.vimrc.keymap $HOME/.vimrc.keymap

        if [ ! -d $HOME/.vim/after ]; then
            mkdir -p $HOME/.vim/after
        fi

        if [ ! -d $HOME/.vim/after/ftplugin ]; then
            mkdir -p $HOME/.vim/after/ftplugin
        fi

        for file in $(find $PWD/.vim/after/ftplugin -maxdepth 1 -type f); do
            ln -sf $PWD/.vim/after/ftplugin/${file##*/} $HOME/.vim/after/ftplugin/${file##*/}
        done

        # setup dein
        if [ ! -d $HOME/.vim/dein ]; then
            mkdir -p $HOME/.vim/dein
        fi
        ln -sf $PWD/.vim/dein/dein.toml $HOME/.vim/dein/dein.toml
        ln -sf $PWD/.vim/dein/dein_lazy.toml $HOME/.vim/dein/dein_lazy.toml
    else
        echo "vim does not exist in $PATH"
    fi
}

echo Setup NeoVim && {
    if type nvim >/dev/null 2>&1; then
        if [ ! -d $HOME/.config/nvim ]; then
            mkdir -p $HOME/.config/nvim
        fi

        ln -sf $PWD/.config/nvim/init.vim $HOME/.config/nvim/init.vim

        if [ ! -d $HOME/.config/nvim/ftplugin ]; then
            mkdir -p $HOME/.config/nvim/ftplugin
        fi

        for file in $(find $PWD/.vim/after/ftplugin -maxdepth 1 -type f); do
            ln -sf $PWD/.vim/after/ftplugin/${file##*/} $HOME/.config/nvim/ftplugin/${file##*/}
        done

        # setup dein
        if [ ! -d $HOME/.config/nvim/dein ]; then
            mkdir -p $HOME/.config/nvim/dein
        fi
        if [ ! -d $HOME/.cache/nvim/dein ]; then
            mkdir -p $HOME/.cache/nvim/dein
        fi
        ln -sf $PWD/.vim/dein/dein.toml $HOME/.config/nvim/dein/plugin.toml
        ln -sf $PWD/.vim/dein/dein_lazy.toml $HOME/.config/nvim/dein/lazy.toml
    else
        echo "neovim does not exist in $PATH"
    fi
}

echo Setup Jetbrains && {
    ln -sf $PWD/.ideavimrc $HOME/.ideavimrc
}

echo Setup Hyper && {
    ln -sf $PWD/.hyper.js $HOME/.hyper.js
}

echo Setup starship && {
    ln -sf $PWD/.config/starship.toml $HOME/.config/starship.toml
}
