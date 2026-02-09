#!/bin/sh

function_RollSymlinks()
{
    function_PrintMessage privilege_User Symlinking

    if [ ! -d "${HOME}/.config/" ]; then
        mkdir "${HOME}/.config/"
    fi

    if [ -d "${HOME}/.vim" ]; then
        rm -rf  "${HOME}/.vim"
    fi

    if [ -d "${HOME}/.config/vifm" ] || [ -L "${HOME}/.config/vifm" ]; then
        rm -rf  "${HOME}/.config/vifm"
    fi

    if [ -d "${HOME}/.config/fastfetch" ] || [ -L "${HOME}/.config/fastfetch" ]; then
        rm -rf  "${HOME}/.config/fastfetch"
    fi

    if [ -d "${HOME}/.config/tmux" ] || [ -L "${HOME}/.config/tmux" ]; then
        rm -rf  "${HOME}/.config/tmux"
    fi

    if [ -d "${HOME}/.config/fd" ] || [ -L "${HOME}/.config/fd" ]; then
        rm -rf  "${HOME}/.config/fd"
    fi

    if [ -d "${HOME}/.config/mc" ] || [ -L "${HOME}/.config/mc" ]; then
        rm -rf  "${HOME}/.config/mc"
    fi

    ln -vsf "${path_DotRoot}/config/mc"           "${HOME}/.config/mc"
    ln -vsf "${path_DotRoot}/config/fd"           "${HOME}/.config/fd"
    ln -vsf "${path_DotRoot}/config/tmux"         "${HOME}/.config/tmux"
    ln -vsf "${path_DotRoot}/config/fastfetch"    "${HOME}/.config/fastfetch"
    ln -vsf "${path_DotRoot}/config/vifm"         "${HOME}/.config/vifm"
    ln -vsf "${path_DotRoot}/config/vim"          "${HOME}/.vim"
    ln -vsf "${path_DotRoot}/config/zsh/zshrc"    "${HOME}/.zshrc"
    ln -vsf "${path_DotRoot}/config/zsh/zprofile" "${HOME}/.zprofile"
    ln -vsf "${path_DotRoot}/config/vim/vimrc"    "${HOME}/.vimrc"
}
