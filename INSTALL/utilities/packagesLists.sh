#!/bin/sh

# Previous Lists
#   git submodule add https://github.com/lervag/vimtex  config/vim/pack/plugins/start/vimtex
#   git submodule add https://github.com/yegappan/lsp   config/vim/pack/plugins/start/lsp

# Fonts
List_of_Fonts="\
    CascadiaCode.tar.xz  \
    FiraCode.tar.xz      \
    Hasklig.tar.xz       \
    Lilex.tar.xz         \
    JetBrainsMono.tar.xz \
    Monoid.tar.xz        \
"

# Repositories
List_of_GPGKeys="\
    ${gpgkey_microsoft} \
    ${gpgkey_librewolf} \
    "

List_of_Repositories="\
    ${repository_vscode}      \
    ${repository_librewolf}   \
    ${repository_broadcom_wl} \
    "

# GIT Submodules
List_of_GitSubmodules="\
     https://github.com/romkatv/powerlevel10k              config/zsh/plugins/powerlevel10k                    \
     https://github.com/zsh-users/zsh-syntax-highlighting  config/zsh/plugins/zsh-syntax-highlighting          \
     https://github.com/zsh-users/zsh-autosuggestions      config/zsh/plugins/zsh-autosuggestions              \
     https://github.com/ap/vim-css-color                   config/vim/pack/plugins/start/css-color             \
     https://github.com/junegunn/fzf                       config/vim/pack/plugins/start/fzf                   \
     https://github.com/junegunn/fzf.vim                   config/vim/pack/plugins/start/fzf.vim               \
     https://github.com/junegunn/goyo.vim                  config/vim/pack/plugins/start/goyo.vim              \
     https://github.com/junegunn/limelight.vim             config/vim/pack/plugins/start/limelight.vim         \
     https://github.com/machakann/vim-highlightedyank      config/vim/pack/plugins/start/vim-highlightedyank   \
     https://github.com/mbbill/undotree                    config/vim/pack/plugins/start/undotree              \
     https://github.com/ntpeters/vim-better-whitespace     config/vim/pack/plugins/start/vim-better-whitespace \
     https://github.com/preservim/vim-indent-guides        config/vim/pack/plugins/start/vim-indent-guides     \
     https://github.com/tpope/vim-surround                 config/vim/pack/plugins/start/surround              \
     https://github.com/vim-airline/vim-airline            config/vim/pack/plugins/start/vim-airline           \
     https://github.com/vim-airline/vim-airline-themes     config/vim/pack/plugins/start/vim-airline-themes    \
    "

# Symlinks
List_of_SymlinksDirRem="\
    ${HOME}/.vim              \
    ${HOME}/.config/vifm      \
    ${HOME}/.config/fastfetch \
    ${HOME}/.config/tmux      \
    ${HOME}/.config/mc        \
    ${HOME}/.config/fd        \
    "

List_of_Symlinks="\
    ${pathDotRoot}/config/zsh/zprofile ${HOME}/.zprofile         \
    ${pathDotRoot}/config/zsh/zshrc    ${HOME}/.zshrc            \
    ${pathDotRoot}/config/vim/vimrc    ${HOME}/.vimrc            \
    ${pathDotRoot}/config/vim          ${HOME}/.vim              \
    ${pathDotRoot}/config/vifm         ${HOME}/.config/vifm      \
    ${pathDotRoot}/config/fastfetch    ${HOME}/.config/fastfetch \
    ${pathDotRoot}/config/tmux         ${HOME}/.config/tmux      \
    ${pathDotRoot}/config/fd           ${HOME}/.config/fd        \
    ${pathDotRoot}/config/mc           ${HOME}/.config/mc        \
   " 

# Restore
List_of_RestoreKDE="\
    aurorae              \
    color-schemes        \
    icons                \
    plasma/desktoptheme  \
    plasma/look-and-feel \
    wallpapers           \
    "

List_of_RestoreMacOS="\
    TG Pro \
    "

# Packages
List_of_x230="\
    ${binary_fprintd}     \
    ${binary_fprintd_pam} \
    ${binary_libfprint}   \
    "

List_of_Hyprland="\
    ${binary_hyprland}       \
    ${binary_hyprland_devel} \
    ${binary_kitty}          \
    "

List_of_KDEPersonal="\
    ${binary_blender}                 \
    ${binary_code}                    \
    ${binary_discord}                 \
    ${binary_ffmpeg}                  \
    ${binary_gimp}                    \
    ${binary_godot}                   \
    ${binary_inkscape}                \
    ${binary_kdenlive}                \
    ${binary_kicad}                   \
    ${binary_kid3}                    \
    ${binary_krita}                   \
    ${binary_kvantum_manager}         \
    ${binary_onedrive}                \
    ${binary_onedrive_completion_zsh} \
    ${binary_oxygentheme}             \
    ${binary_qbittorrent}             \
    ${binary_strawberry}              \
    ${binary_virt_manager}            \
    ${binary_vlc}                     \
    "

List_of_KDEBasics="\
    ${binary_keepassxc}     \
    ${binary_myspell_pt_PT} \
    "

List_of_KDEFortiClient="\
    ${binary_networkmanager_fortisslvpn} \
    ${binary_openfortivpn}               \
    ${binary_plasma6_nm_fortisslvpn}     \
    "

List_of_WSLPattern="\
    ${binary_wsl_base}    \
    ${binary_wsl_gui}     \
    ${binary_wsl_systemd} \
    "

List_of_Developer="\
    ${binary_gcc}        \
    ${binary_gdb}        \
    ${binary_make}       \
    ${binary_shellcheck} \
    ${binary_valgrind}   \
    "

List_of_Terminal="\
    ${binary_bat}                    \
    ${binary_btop}                   \
    ${binary_curl}                   \
    ${binary_eza}                    \
    ${binary_fastfetch}              \
    ${binary_fd}                     \
    ${binary_fd_zsh_completion}      \
    ${binary_fzf}                    \
    ${binary_fzf_tmux}               \
    ${binary_fzf_zsh_completion}     \
    ${binary_htop}                   \
    ${binary_lazygit}                \
    ${binary_man_pages}              \
    ${binary_mc}                     \
    ${binary_ripgrep}                \
    ${binary_ripgrep_zsh_completion} \
    ${binary_shellcheck}             \
    ${binary_tmux}                   \
    ${binary_vifm}                   \
    ${binary_vifm_colors}            \
    ${binary_vim}                    \
    ${binary_vim_data}               \
    ${binary_vim_fzf}                \
    ${binary_zsh}                    \
    "

List_of_ServerCLI="\
    ${binary_curl}                   \
    ${binary_fd}                     \
    ${binary_fd_zsh_completion}      \
    ${binary_fzf}                    \
    ${binary_fzf_tmux}               \
    ${binary_fzf_zsh_completion}     \
    ${binary_htop}                   \
    ${binary_ripgrep}                \
    ${binary_ripgrep_zsh_completion} \
    ${binary_tmux}                   \
    ${binary_vifm}                   \
    ${binary_vifm_colors}            \
    ${binary_vim}                    \
    ${binary_vim_data}               \
    ${binary_vim_fzf}                \
    ${binary_zsh}                    \

    "

List_of_ServerGUI="\
    ${binary_xorgxrdp} \
    ${binary_xrdp}     \
    "

List_of_iSH="\
    ${binary_build_base}  \
    ${binary_gcc}         \
    ${binary_gdb}         \
    ${binary_git_doc}     \
    ${binary_less}        \
    ${binary_less_doc}    \
    ${binary_man_pages}   \
    ${binary_openssh}     \
    ${binary_vifm_colors} \
    "

List_of_Flatpaks="\
    ${flat_signaldesktop} \
    ${flat_remotedesktop} \
    ${flat_obsidianmd}    \
    ${flat_puddletag}     \
    "
