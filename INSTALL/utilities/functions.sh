#!/bin/sh

# File: home_functions.sh
# Description: functions for home_setup.sh

# TODO:
#   functionInstallPackages:
#       Add host virtual machine
#       Add SSH sessions

functionSystemPrintMessage() 
{
    case "${1}" in
        "privilegeRoot")
            case "${2}" in
                "fixes")                printf '%s\n' "Computer Fixes" ;;
                "repositories")         printf '%s\n' "Repositories" ;;
                "packages")             printf '%s\n' "Packages" ;;
                "vmTemplateCleanUp")    printf '%s\n' "Preparing Template" ;;
            esac

            printf '%s\n'   "${messageLongDash}" \
                            "" \
                            "${messageLongWarn}" "${messageExecRoot}" "${messageLongWarn}" \
                            ""
        ;;

        "privilegeUser")
            case "${2}" in
                "fonts")                printf '%s\n' "Fonts" ;;
                "symlinking")           printf '%s\n' "Symlinking" ;;
                "gitConfig")            printf '%s\n' "Git globals configuration." ;;
                "syncGitSubmodule")     printf '%s\n' "Syncing git submodules" ;;
                "vimHelptags")          printf '%s\n' "Linking VIM Helptags" ;;
                "zshShell")             printf '%s\n' "Changing to ZSH" ;;
                "rebuildSubmodules")    printf '%s\n' "Rebuilding git submodules" ;;
                "restoreKDE")           printf '%s\n' "Restoring KDE settings" ;;
            esac

            printf '%s\n'   "${messageLongDash}" \
                            ""
        ;;

        "printsleep")
            printf '%s\n'   ""
            sleep 3s
        ;;
    esac
}

functionSystemBuildMenu() 
{
    printf '%s\n'   "                                                                " \
                    "|--------------------------------------------------------------|" \
                    "| Select an option:                                            |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( 1) Run all                 |  ( 6) Symlinks               |" \
                    "|  ( 2) Repositories            |  ( 7) Configure git globals  |" \
                    "|  ( 3) Packages                |  ( 8) Sync git submodules    |" \
                    "|  ( 4) Fixes                   |  ( 9) Link vim helptags      |" \
                    "|  ( 5) Fonts                   |  (10) Change to zsh shell    |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( r) rebuild git submodules                                 |" \
                    "|--------------------------------------------------------------|" \
                    "|  host: ${currentHost}                                         " \
                    "|  distribuition: "${ID}"                                       " \
                    "|  package manager: "${packageManager}"                         " \
                    "|  current shell: "${SHELL}"                                    " \
                    "|  pwd: $(pwd)                                                  " \
                    "|  repository root: "${pathDotRoot}"                            " \
                    "|  cache directory: "${pathCache}"                              " \
                    "|--------------------------------------------------------------|" \
                    "|  ( ) exit / cancel                                           |" \
                    "|--------------------------------------------------------------|" \
                    "                                                                "
}

functionSystemInfoMenu() 
{
    printf '%s\n'   "                                                                " \
                    "|--------------------------------------------------------------|" \
                    "| Select an option:                                            |" \
                    "|--------------------------------------------------------------|" \
                    "|  Host: ${currentHost}                                         " \
                    "|  Distribuition: ${ID}                                         " \
                    "|                                                               " \
                    "|  Package manager: ${packageManager}                           " \
                    "|  Package install command: ${packageInstallCommand}            " \
                    "|                                                               " \
                    "|  Current shell: ${SHELL}                                      " \
                    "|  Pwd: $(pwd)                                                  " \
                    "|--------------------------------------------------------------|" \
                    "|  Repository root: ${pathDotRoot}                              " \
                    "|  Cache directory: ${pathCache}                                " \
                    "|  Script path: ${pathScript}                                   " \
                    "|  Utilities path: ${pathUtilities}                             " \
                    "|--------------------------------------------------------------|" \
                    "|  $0                                                           " \
                    "|--------------------------------------------------------------|" \
                    "                                                                "
}

functionSystemDefineDistro() 
{
    # Flatpak universal
    flatpakManager="flatpak"
    flatpakUpdate="flatpak update"
    flatpakInstallCommand="flatpak install -y"

    flat_signaldesktop="org.signal.Signal"
    flat_remotedesktop="net.devolutions.RDM"
    flat_obsidianmd="md.obsidian.Obsidian"
    flat_puddletag="net.puddletag.puddletag"

    # Some distribuitions have different package names and software paths.
    case "${ID}" in
        "opensuse-tumbleweed")
            packageManager="zypper"
            packageUpdate="zypper up"
            packageUpgrade="zypper dup"
            packageInstallCommand="zypper install -y"
            distroName="opensuse-tumbleweed"
            zshInstallPath="/usr/share/zsh"

            binary_apache2="apache2"
            binary_bat="bat"
            binary_blender="blender"
            binary_btop="btop"
            binary_build_base=""
            binary_build_essential=""
            binary_code="code"
            binary_curl="curl"
            binary_discord="discord"
            binary_eza="eza"
            binary_fastfetch="fastfetch"
            binary_fd="fd"
            binary_fd_zsh_completion="fd-zsh-completion"
            binary_ffmpeg="ffmpeg-7"
            binary_fprintd="fprintd"
            binary_fprintd_pam="fprintd-pam"
            binary_fzf="fzf"
            binary_fzf_tmux="fzf-tmux"
            binary_fzf_zsh_completion="fzf-zsh-completion"
            binary_gcc="gcc"
            binary_gdal_data=""
            binary_gdal_plugins=""
            binary_gdb="gdb"
            binary_gdebi_core=""
            binary_gimp="gimp"
            binary_git_doc=""
            binary_godot="godot"
            binary_htop="htop"
            binary_hyprland="hyprland"
            binary_hyprland_devel="hyprland-devel"
            binary_ifuse="ifuse"
            binary_inkscape="inkscape"
            binary_kdenlive="kdenlive"
            binary_keepassxc="keepassxc"
            binary_kicad="kicad"
            binary_kid3="kid3"
            binary_kitty="kitty"
            binary_krita="krita"
            binary_kvantum_manager="kvantum-manager"
            binary_lazygit="lazygit"
            binary_less=""
            binary_less_doc=""
            binary_libfontconfig1_dev=""
            binary_libfprint="libfprint"
            binary_libfribidi_dev=""
            binary_libharfbuzz_dev=""
            binary_libjq_dev=""
            binary_libmagickplusplus_dev=""
            binary_libprotobuf_dev=""
            binary_librsvg2_dev=""
            binary_libsecret_1_dev=""
            binary_libsodium_dev=""
            binary_libudunits2_dev=""
            binary_libv8_dev=""
            binary_libxml2_dev=""
            binary_make="make"
            binary_man_pages="man-pages"
            binary_mc="mc"
            binary_myspell_pt_PT="myspell-pt_PT"
            binary_NetworkManager_fortisslvpn="NetworkManager-fortisslvpn"
            binary_openfortivpn="openfortivpn"
            binary_openssh=""
            binary_oxygentheme="oxygen6"
            binary_plasma6_nm_fortisslvpn="plasma6-nm-fortisslvpn"
            binary_protobuf_compiler=""
            binary_qbittorrent="qbittorrent"
            binary_r_base=""
            binary_r_base_core=""
            binary_r_base_dev=""
            binary_r_base_html=""
            binary_r_cran_boot=""
            binary_r_cran_class=""
            binary_r_cran_mass=""
            binary_r_cran_nlme=""
            binary_r_cran_sp=""
            binary_r_cran_spatial=""
            binary_ripgrep="ripgrep"
            binary_ripgrep_zsh_completion="ripgrep-zsh-completion"
            binary_shellcheck="ShellCheck"
            binary_strawberry="strawberry"
            binary_tmux="tmux"
            binary_valgrind="valgrind"
            binary_vifm="vifm"
            binary_vifm_colors="vifm-colors"
            binary_vim="vim"
            binary_vim_data="vim-data"
            binary_vim_fzf="vim-fzf"
            binary_virt_manager="virt-manager"
            binary_vlc="vlc"
            binary_wsl_base="wsl_base"
            binary_wsl_gui="wsl_gui"
            binary_wsl_systemd="wsl_systemd"
            binary_xorgxrdp="xorgxrdp"
            binary_xrdp="xrdp"
            binary_zsh="zsh"
            ;;
        "debian")
            packageManager="apt"
            packageUpdate="apt update"
            packageUpgrade="apt -y upgrade"
            packageInstallCommand="apt -y install"
            distroName="debian"
            zshInstallPath="/usr/share/zsh"

            binary_apache2="apache2"
            binary_bat=""
            binary_blender=""
            binary_btop=""
            binary_build_base=""
            binary_build_essential="build-essential"
            binary_code=""
            binary_curl=""
            binary_discord=""
            binary_eza=""
            binary_fastfetch=""
            binary_fd="fd-find"
            binary_fd_zsh_completion=""
            binary_ffmpeg=""
            binary_fprintd=""
            binary_fprintd_pam=""
            binary_fzf=""
            binary_fzf_tmux=""
            binary_fzf_zsh_completion=""
            binary_gcc=""
            binary_gdal_data="gdal-data"
            binary_gdal_plugins="gdal-plugins"
            binary_gdb=""
            binary_gdebi_core="gdebi-core"
            binary_gimp=""
            binary_git_doc=""
            binary_godot=""
            binary_htop=""
            binary_hyprland=""
            binary_hyprland_devel=""
            binary_ifuse=""
            binary_inkscape=""
            binary_kdenlive=""
            binary_keepassxc=""
            binary_kicad=""
            binary_kid3=""
            binary_kitty=""
            binary_krita=""
            binary_kvantum_manager=""
            binary_lazygit=""
            binary_less=""
            binary_less_doc=""
            binary_libfontconfig1_dev="libfontconfig1-dev"
            binary_libfprint=""
            binary_libfribidi_dev="libfribidi-dev"
            binary_libharfbuzz_dev="libharfbuzz-dev"
            binary_libjq_dev="libjq-dev"
            binary_libmagickplusplus_dev="libmagick++-dev"
            binary_libprotobuf_dev="libprotobuf-dev"
            binary_librsvg2_dev="librsvg2-dev"
            binary_libsecret_1_dev="libsecret-1-dev"
            binary_libsodium_dev="libsodium-dev"
            binary_libudunits2_dev="libudunits2-dev"
            binary_libv8_dev="libv8-dev"
            binary_libxml2_dev="libxml2-dev"
            binary_make=""
            binary_man_pages=""
            binary_mc=""
            binary_myspell_pt_PT=""
            binary_NetworkManager_fortisslvpn=""
            binary_openfortivpn=""
            binary_openssh=""
            binary_oxygentheme=""
            binary_plasma6_nm_fortisslvpn=""
            binary_protobuf_compiler="protobuf-compiler"
            binary_qbittorrent=""
            binary_r_base="r-base"
            binary_r_base_core="r-base-core"
            binary_r_base_dev="r-base-dev"
            binary_r_base_html="r-base-html"
            binary_r_cran_boot="r-cran-boot"
            binary_r_cran_class="r-cran-class"
            binary_r_cran_mass="r-cran-mass"
            binary_r_cran_nlme="r-cran-nlme"
            binary_r_cran_sp="r-cran-sp"
            binary_r_cran_spatial="r-cran-spatial"
            binary_ripgrep=""
            binary_ripgrep_zsh_completion=""
            binary_shellcheck=""
            binary_strawberry=""
            binary_tmux=""
            binary_valgrind=""
            binary_vifm=""
            binary_vifm_colors=""
            binary_vim=""
            binary_vim_data="vim-common"
            binary_vim_fzf=""
            binary_virt_manager=""
            binary_vlc=""
            binary_wsl_base=""
            binary_wsl_gui=""
            binary_wsl_systemd=""
            binary_xorgxrdp=""
            binary_xrdp=""
            binary_zsh=""
            ;;
        "archlinux")
            packageManager="pacman"
            packageUpdate="pacman -Sy"
            packageUpgrade="pacman -Syu"
            packageInstallCommand="pacman -S"
            distroName="arch"
            zshInstallPath="/usr/share/zsh"

            binary_apache2="apache"
            binary_bat=""
            binary_blender=""
            binary_btop=""
            binary_build_base=""
            binary_build_essential=""
            binary_code=""
            binary_curl=""
            binary_discord=""
            binary_eza=""
            binary_fastfetch=""
            binary_fd=""
            binary_fd_zsh_completion=""
            binary_ffmpeg=""
            binary_fprintd=""
            binary_fprintd_pam=""
            binary_fzf=""
            binary_fzf_tmux=""
            binary_fzf_zsh_completion=""
            binary_gcc=""
            binary_gdal_data=""
            binary_gdal_plugins=""
            binary_gdb=""
            binary_gdebi_core=""
            binary_gimp=""
            binary_git_doc=""
            binary_godot=""
            binary_htop=""
            binary_hyprland=""
            binary_hyprland_devel=""
            binary_ifuse=""
            binary_inkscape=""
            binary_kdenlive=""
            binary_keepassxc=""
            binary_kicad=""
            binary_kid3=""
            binary_kitty=""
            binary_krita=""
            binary_kvantum_manager=""
            binary_lazygit=""
            binary_less=""
            binary_less_doc=""
            binary_libfontconfig1_dev=""
            binary_libfprint=""
            binary_libfribidi_dev=""
            binary_libharfbuzz_dev=""
            binary_libjq_dev=""
            binary_libmagickplusplus_dev=""
            binary_libprotobuf_dev=""
            binary_librsvg2_dev=""
            binary_libsecret_1_dev=""
            binary_libsodium_dev=""
            binary_libudunits2_dev=""
            binary_libv8_dev=""
            binary_libxml2_dev=""
            binary_make=""
            binary_man_pages=""
            binary_mc=""
            binary_myspell_pt_PT=""
            binary_NetworkManager_fortisslvpn=""
            binary_openfortivpn=""
            binary_openssh=""
            binary_oxygentheme=""
            binary_plasma6_nm_fortisslvpn=""
            binary_protobuf_compiler=""
            binary_qbittorrent=""
            binary_r_base=""
            binary_r_base_core=""
            binary_r_base_dev=""
            binary_r_base_html=""
            binary_r_cran_boot=""
            binary_r_cran_class=""
            binary_r_cran_mass=""
            binary_r_cran_nlme=""
            binary_r_cran_sp=""
            binary_r_cran_spatial=""
            binary_ripgrep=""
            binary_ripgrep_zsh_completion=""
            binary_shellcheck=""
            binary_strawberry=""
            binary_tmux=""
            binary_valgrind=""
            binary_vifm=""
            binary_vifm_colors=""
            binary_vim=""
            binary_vim_data=""
            binary_vim_fzf=""
            binary_virt_manager=""
            binary_vlc=""
            binary_wsl_base=""
            binary_wsl_gui=""
            binary_wsl_systemd=""
            binary_xorgxrdp=""
            binary_xrdp=""
            binary_zsh=""
            ;;
        "almalinux")
            packageManager="dnf"
            packageUpdate="dnf update"
            packageUpgrade="dnf upgrade -y"
            packageInstallCommand="dnf install -y"
            distroName="almalinux"
            zshInstallPath="/usr/share/zsh"

            binary_apache2=""
            binary_bat=""
            binary_blender=""
            binary_btop=""
            binary_build_base=""
            binary_build_essential=""
            binary_code=""
            binary_curl=""
            binary_discord=""
            binary_eza=""
            binary_fastfetch=""
            binary_fd=""
            binary_fd_zsh_completion=""
            binary_ffmpeg=""
            binary_fprintd=""
            binary_fprintd_pam=""
            binary_fzf=""
            binary_fzf_tmux=""
            binary_fzf_zsh_completion=""
            binary_gcc=""
            binary_gdal_data=""
            binary_gdal_plugins=""
            binary_gdb=""
            binary_gdebi_core=""
            binary_gimp=""
            binary_git_doc=""
            binary_godot=""
            binary_htop=""
            binary_hyprland=""
            binary_hyprland_devel=""
            binary_ifuse=""
            binary_inkscape=""
            binary_kdenlive=""
            binary_keepassxc=""
            binary_kicad=""
            binary_kid3=""
            binary_kitty=""
            binary_krita=""
            binary_kvantum_manager=""
            binary_lazygit=""
            binary_less=""
            binary_less_doc=""
            binary_libfontconfig1_dev=""
            binary_libfprint=""
            binary_libfribidi_dev=""
            binary_libharfbuzz_dev=""
            binary_libjq_dev=""
            binary_libmagickplusplus_dev=""
            binary_libprotobuf_dev=""
            binary_librsvg2_dev=""
            binary_libsecret_1_dev=""
            binary_libsodium_dev=""
            binary_libudunits2_dev=""
            binary_libv8_dev=""
            binary_libxml2_dev=""
            binary_make=""
            binary_man_pages=""
            binary_mc=""
            binary_myspell_pt_PT=""
            binary_NetworkManager_fortisslvpn=""
            binary_openfortivpn=""
            binary_openssh=""
            binary_oxygentheme=""
            binary_plasma6_nm_fortisslvpn=""
            binary_protobuf_compiler=""
            binary_qbittorrent=""
            binary_r_base=""
            binary_r_base_core=""
            binary_r_base_dev=""
            binary_r_base_html=""
            binary_r_cran_boot=""
            binary_r_cran_class=""
            binary_r_cran_mass=""
            binary_r_cran_nlme=""
            binary_r_cran_sp=""
            binary_r_cran_spatial=""
            binary_ripgrep=""
            binary_ripgrep_zsh_completion=""
            binary_shellcheck=""
            binary_strawberry=""
            binary_tmux=""
            binary_valgrind=""
            binary_vifm=""
            binary_vifm_colors=""
            binary_vim=""
            binary_vim_data=""
            binary_vim_fzf=""
            binary_virt_manager=""
            binary_vlc=""
            binary_wsl_base=""
            binary_wsl_gui=""
            binary_wsl_systemd=""
            binary_xorgxrdp=""
            binary_xrdp=""
            binary_zsh=""
            ;;
        "alpine")
            packageManager="apk"
            packageUpdate=""
            packageUpgrade=""
            packageInstallCommand="apk add"
            distroName="alpine"
            zshInstallPath="/usr/share/zsh"

            binary_apache2=""
            binary_bat=""
            binary_blender=""
            binary_btop=""
            binary_build_base="build-base"
            binary_build_essential=""
            binary_code=""
            binary_curl=""
            binary_discord=""
            binary_eza=""
            binary_fastfetch=""
            binary_fd=""
            binary_fd_zsh_completion=""
            binary_ffmpeg=""
            binary_fprintd=""
            binary_fprintd_pam=""
            binary_fzf=""
            binary_fzf_tmux=""
            binary_fzf_zsh_completion=""
            binary_gcc=""
            binary_gdal_data=""
            binary_gdal_plugins=""
            binary_gdb=""
            binary_gdebi_core=""
            binary_gimp=""
            binary_git_doc="git-doc"
            binary_godot=""
            binary_htop=""
            binary_hyprland=""
            binary_hyprland_devel=""
            binary_ifuse=""
            binary_inkscape=""
            binary_kdenlive=""
            binary_keepassxc=""
            binary_kicad=""
            binary_kid3=""
            binary_kitty=""
            binary_krita=""
            binary_kvantum_manager=""
            binary_lazygit=""
            binary_less="less"
            binary_less_doc="less-doc"
            binary_libfontconfig1_dev=""
            binary_libfprint=""
            binary_libfribidi_dev=""
            binary_libharfbuzz_dev=""
            binary_libjq_dev=""
            binary_libmagickplusplus_dev=""
            binary_libprotobuf_dev=""
            binary_librsvg2_dev=""
            binary_libsecret_1_dev=""
            binary_libsodium_dev=""
            binary_libudunits2_dev=""
            binary_libv8_dev=""
            binary_libxml2_dev=""
            binary_make=""
            binary_man_pages=""
            binary_mc=""
            binary_myspell_pt_PT=""
            binary_NetworkManager_fortisslvpn=""
            binary_openfortivpn=""
            binary_openssh="openssh"
            binary_oxygentheme=""
            binary_plasma6_nm_fortisslvpn=""
            binary_protobuf_compiler=""
            binary_qbittorrent=""
            binary_r_base=""
            binary_r_base_core=""
            binary_r_base_dev=""
            binary_r_base_html=""
            binary_r_cran_boot=""
            binary_r_cran_class=""
            binary_r_cran_mass=""
            binary_r_cran_nlme=""
            binary_r_cran_sp=""
            binary_r_cran_spatial=""
            binary_ripgrep=""
            binary_ripgrep_zsh_completion=""
            binary_shellcheck=""
            binary_strawberry=""
            binary_tmux=""
            binary_valgrind=""
            binary_vifm=""
            binary_vifm_colors="vifm-colors --force-overwrite"
            binary_vim=""
            binary_vim_data=""
            binary_vim_fzf=""
            binary_virt_manager=""
            binary_vlc=""
            binary_wsl_base=""
            binary_wsl_gui=""
            binary_wsl_systemd=""
            binary_xorgxrdp=""
            binary_xrdp=""
            binary_zsh=""
            ;;
        "macOS")
            packageManager="brew"
            packageUpdate="brew update"
            packageUpgrade="brew upgrade"
            packageInstallCommand="brew bundle install"
            distroName="macOS"
            zshInstallPath="/usr/share/zsh"
            ;;
        *)
            printf '%s\n'   "This script doesn't support distribuition: "${ID}"" \
                            "Exiting."
            exit 0
            ;;
    esac
}

functionSystemDefineHost() 
{
    # dmi directory indicates a physical machine
    if [ -d "/sys/devices/virtual/dmi" ]; then
        currentHost="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"

    # ish directory is only available on Apple devices running iSH.app
    elif [ -d "/proc/ish" ]; then
        currentHost="iOS/iPadOS"

    # software_vers gives macos os name and version, ergo we can get the hostname from sysctl
    elif [ -d "/usr/bin/software_vers" ]; then
        currentHost="$(sysctl hw.model)"

    # WT_SESSION environment variable available in WSL1 and WSL2
    elif [ "${wslsession}" ]; then 
        currentHost="Windows Subsystem for Linux"

    # If none of the above
    else
        currentHost="None"
    fi
}

functionGenericInstallCommands()
{
    case "${1}" in
        "OhMyPosh")
            curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin ;;
        *)  ;;
    esac

    case "${2}" in
        "KDELenovo")
            su -c "$packageInstallCommand \
                $list_Terminal \
                $list_Dev \
                $list_KDEBasics \
                $list_KDEPersonal \
                $list_x230 \
                ";

            su -c "$flatpakInstallCommand \
                $list_Flatpak \
                "
            ;;
           
        "KDEMacbook")
            su -c "$packageInstallCommand \
                $list_Terminal \
                $list_Dev \
                $list_KDEBasics \
                $list_KDEPersonal \
                $list_maclinux \
                ";

            su -c "$flatpakInstallCommand \
                $list_Flatpak \
                "
            ;;
           
        "KDEDefault")
            su -c "$packageInstallCommand \
                $list_Terminal \
                $list_KDEBasics \
                ";
            ;;

        "TerminalDefault")
            su -c "$packageInstallCommand \
                $list_Terminal \
                $list_Dev \
                ";
            ;;

        "HyprlandDefault")
            su -c "${packageInstallCommand} \
                ${list_Terminal} \
                ${list_Dev} \
                ${list_Hyprland} \
                ${list_KDEPersonal} \
                ";
            ;;

        "AppleMobile")
            "$packageInstallCommand \
                $list_Terminal \
                $list_iSH \
                "
            ;;

        *)  ;;
    esac

}

functionInstallRepositories() 
{
    functionSystemPrintMessage privilegeRoot repositories

    case "${distroName}" in
        "opensuse-tumbleweed")
            su -c "
                rpm --import https://packages.microsoft.com/keys/microsoft.asc ;
                rpm --import https://rpm.librewolf.net/pubkey.gpg ;
                zypper ar https://packages.microsoft.com/yumrepos/vscode vscode ;
                zypper ar -ef https://rpm.librewolf.net librewolf ;
                zypper addrepo https://download.opensuse.org/repositories/home:Sauerland:hardware/openSUSE_Tumbleweed/home:Sauerland:hardware.repo ;
                zypper --gpg-auto-import-keys ref ;
                "
                # Last command is the same as "zypper refresh" but also accepts automatically keys
            ;;

        *)
            printf '%s\n' "No repository to add."
            ;;
    esac

    functionSystemPrintMessage printsleep
}

functionInstallPackages() 
{
    functionSystemPrintMessage privilegeRoot packages

    case "${currentHost}" in
        "LENOVO ThinkPad X230 - 23252FG")
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    functionGenericInstallCommands OhMyPosh KDELenovo
                    ;;

                "hyprland")
                    functionGenericInstallCommands OhMyPosh HyprlandDefault
                    ;;

                *)
                    functionGenericInstallCommands OhMyPosh TerminalDefault
                    ;;
            esac
            ;;

        "Windows Subsystem for Linux")
            functionGenericInstallCommands OhMyPosh TerminalDefault
            if [ "${distroName}" = "opensuse-tumbleweed" ]; then su -c "$packageInstallCommand -t pattern $list_WSLPattern"; fi
            ;;

        "iOS/iPadOS")
            functionGenericInstallCommands AppleMobile
            ;;

        "Apple Inc. 1.0 - MacBookPro9,2")
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    functionGenericInstallCommands OhMyPosh KDEMacbook
                    ;;

                "hyprland")
                    functionGenericInstallCommands OhMyPosh HyprlandDefault
                    ;;

                *)
                    functionGenericInstallCommands OhMyPosh TerminalDefault
                    ;;
            esac
            ;;

        "MacBook9,2")
            "$packageInstallCommand --file=${dir_dotroot}/INSTALL/Brewfile"
            ;;

        *)
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    functionGenericInstallCommands OhMyPosh KDEDefault
                    ;;

                *) ;;
            esac
    esac

    functionSystemPrintMessage printsleep
}

functionInstallFixes() 
{
    functionSystemPrintMessage privilegeRoot fixes

    # Hardware layer
    case "${currentHost}" in
        "MacBookPro9,2")
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
            ;;

        "Apple Inc. 1.0 - MacBookPro9,2")
            su -c "$packageInstallCommand broadcom-wl"
            ;;
        *)
            printf '%s\n' "Hardware running smoothly"
            ;;
    esac

    # Operting system layer
    case "${distroName}" in
        "debian")
            printf '%s\n' "Symlinking fd-find"

            ln -s $(which fdfind) "${HOME}/.local/bin/fd"
            ;;

        *)
            printf '%s\n' "Operating system running smoothly"
            ;;
    esac

    functionSystemPrintMessage printsleep
}

functionInstallFonts() 
{
    functionSystemPrintMessage privilegeUser fonts

    if [ ! -d "${HOME}/.fonts" ] ; then mkdir -p "${HOME}/.fonts" ; fi
    if [ ! -d "${pathCache}" ] ; then mkdir -p "${pathCache}" ; fi

    if [ "$(curl -is "${urlNerdFonts}" | head -n 1)" = "HTTP/2 404" ] ; then
        for dl_fonts in $(ls "${pathDotRoot}/INSTALL/fonts/*.tar.xz")
        do
            tar -xvf "${pathDotRoot}/INSTALL/fonts/${downloadedFonts}" --directory "${HOME}/.fonts"
        done
    else
        for downloadedFonts in ${packages_fonts}
        do
            curl -L $(curl -s "${urlNerdFonts}" | grep browser_download_url | cut -d '"' -f 4 | grep "${downloadedFonts}") --output "${pathCache}/${downloadedFonts}"
            tar -xvf "${pathCache}/${downloadedFonts}" --directory "${HOME}/.fonts"
            rm "${pathCache}/${downloadedFonts}"
        done
    fi

    rm "${HOME}/.fonts/LICENSE.txt"
    rm "${HOME}/.fonts/LICENSE.md"
    rm "${HOME}/.fonts/license.txt"
    rm "${HOME}/.fonts/license.md"
    rm "${HOME}/.fonts/README.txt"
    rm "${HOME}/.fonts/README.md"
    rm "${HOME}/.fonts/readme.txt"
    rm "${HOME}/.fonts/readme.md"
    rm "${HOME}/.fonts/OFL.txt"

    functionSystemPrintMessage printsleep
}

functionInstallSymlinks() 
{
    functionSystemPrintMessage privilegeUser symlinking

    [ ! -d "${HOME}/.config/" ]         && mkdir "${HOME}/.config/"

    [ -d "${HOME}/.vim" ]               && rm -rf "${HOME}/.vim"
    [ -d "${HOME}/.config/vifm" ]       && rm -rf "${HOME}/.config/vifm"
    [ -d "${HOME}/.config/fastfetch" ]  && rm -rf "${HOME}/.config/fastfetch"
    [ -d "${HOME}/.config/tmux" ]       && rm -rf "${HOME}/.config/tmux"
    [ -d "${HOME}/.config/mc" ]         && rm -rf "${HOME}/.config/mc"
    [ -d "${HOME}/.config/fd" ]         && rm -rf "${HOME}/.config/fd"

    # Files
    ln -vsf "${pathDotRoot}/config/zsh/zprofile"    "${HOME}/.zprofile"
    ln -vsf "${pathDotRoot}/config/zsh/zshrc"       "${HOME}/.zshrc"
    ln -vsf "${pathDotRoot}/config/vim/vimrc"       "${HOME}/.vimrc"

    # Directories
    ln -vsf "${pathDotRoot}/config/vim"         "${HOME}/.vim"
    ln -vsf "${pathDotRoot}/config/vifm"        "${HOME}/.config/vifm"
    ln -vsf "${pathDotRoot}/config/fastfetch"   "${HOME}/.config/fastfetch"
    ln -vsf "${pathDotRoot}/config/tmux"        "${HOME}/.config/tmux"
    ln -vsf "${pathDotRoot}/config/fd"          "${HOME}/.config/fd"
    ln -vsf "${pathDotRoot}/config/mc"          "${HOME}/.config/mc"

    functionSystemPrintMessage printsleep
}

functionConfigGitGlobals() 
{
    functionSystemPrintMessage privilegeUser gitConfig

    printf '%s'     "user.email: "
    read -r git_user_email
    printf '%s\n'   ""
    git config --global user.email "${git_user_email}"

    printf '%s\n'   ""

    printf '%s'     "user.name: "
    read -r git_user_name
    printf '%s\n'   ""
    git config --global user.name "${git_user_name}"

    functionSystemPrintMessage printsleep
}

functionConfigGitSubmodules() 
{
    functionSystemPrintMessage privilegeUser syncGitSubmodule

    # A repository with submodules already added must be initiated.
    (cd "${pathDotRoot}" && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    functionSystemPrintMessage printsleep
}

functionConfigVimHelptags() 
{
    functionSystemPrintMessage privilegeUser vimHelptags

    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/vim-airline/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/vim-airline-themes/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/surround/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/commentary/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/fugitive/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/undotree/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/fzf/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/fzf-vim/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/goyo.vim/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/vim-highlightedyank/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/vim-better-whitespace/doc" -c q
    vim -u NONE -c helptags "${pathDotRoot}/config/vim/pack/plugins/start/vim-indent-guides/doc" -c q

    functionSystemPrintMessage printsleep
}

functionConfigShell() 
{
    functionSystemPrintMessage privilegeUser zshShell

    printf '%s\n' "Current shell: ${SHELL}"

    # Check if running shell is ZSH.
    if [ "${SHELL}" != "/usr/bin/zsh" ] ; then
        # Check if ZSH is installed.
        if [ ! -f "${zshInstallPath}" ] ; then
            # iSH uses a different method for shell changing.
            if [ "${currentHost}" = "iOS/iPadOS" ] ; then
                sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh in /etc/passwd file, close and re-open iSH to apply."
            else
                # Change the shell
                chsh -s "$(which zsh)" && printf '%s\n' "Shell changed to ZSH." || printf '%s\n' "ERROR: Shell not changed."
            fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read  -r optionZSHChange
            if [ "${optionZSHChange}" = "y" ] ; then
                (su -c "${packageInstallCommand}" "zsh")
                functionConfigShell
            fi
        fi
    else
        printf '%s\n' "ZSH already running."
    fi

    functionSystemPrintMessage printsleep
}

functionRebuildGitSubmodules() 
{
    functionSystemPrintMessage privilegeUser rebuildSubmodules

    previous_pwd="$(pwd)"

    # NOTE: submodule path is relative to root repository.
    (cd "${pathDotRoot}" &&
        git submodule add https://github.com/romkatv/powerlevel10k              config/zsh/plugins/powerlevel10k
        git submodule add https://github.com/zsh-users/zsh-syntax-highlighting  config/zsh/plugins/zsh-syntax-highlighting
        git submodule add https://github.com/zsh-users/zsh-autosuggestions      config/zsh/plugins/zsh-autosuggestions
        git submodule add https://github.com/ap/vim-css-color                   config/vim/pack/plugins/start/css-color
        git submodule add https://github.com/junegunn/fzf                       config/vim/pack/plugins/start/fzf
        git submodule add https://github.com/junegunn/fzf.vim                   config/vim/pack/plugins/start/fzf.vim
        git submodule add https://github.com/junegunn/goyo.vim                  config/vim/pack/plugins/start/goyo.vim
        git submodule add https://github.com/junegunn/limelight.vim             config/vim/pack/plugins/start/limelight.vim
        git submodule add https://github.com/machakann/vim-highlightedyank      config/vim/pack/plugins/start/vim-highlightedyank
        git submodule add https://github.com/mbbill/undotree                    config/vim/pack/plugins/start/undotree
        git submodule add https://github.com/ntpeters/vim-better-whitespace     config/vim/pack/plugins/start/vim-better-whitespace
        git submodule add https://github.com/preservim/vim-indent-guides        config/vim/pack/plugins/start/vim-indent-guides
        git submodule add https://github.com/tpope/vim-surround                 config/vim/pack/plugins/start/surround
        git submodule add https://github.com/vim-airline/vim-airline            config/vim/pack/plugins/start/vim-airline
        git submodule add https://github.com/vim-airline/vim-airline-themes     config/vim/pack/plugins/start/vim-airline-themes
    )

        # Previously enabled (for reference)
        #   git submodule add https://github.com/lervag/vimtex                      config/vim/pack/plugins/start/vimtex
        #   git submodule add https://github.com/yegappan/lsp                       config/vim/pack/plugins/start/lsp

    cd "${previous_pwd}"

    functionSystemPrintMessage printsleep
}

functionRestoreKDE()
{
    functionSystemPrintMessage privilegeUser restoreKDE

    [ -d "${HOME}/.local/share/aurorae" ]                  && rm -rf "${HOME}/.local/share/aurorae"
    [ -d "${HOME}/.local/share/color-schemes" ]            && rm -rf "${HOME}/.local/share/color-schemes"
    [ -d "${HOME}/.local/share/icons" ]                    && rm -rf "${HOME}/.local/share/icons"
    [ -d "${HOME}/.local/share/plasma/desktoptheme" ]      && rm -rf "${HOME}/.local/share/plasma/desktoptheme"
    [ -d "${HOME}/.local/share/plasma/look-and-feel" ]     && rm -rf "${HOME}/.local/share/plasma/look-and-feel"
    [ -d "${HOME}/.local/share/wallpapers" ]               && rm -rf "${HOME}/.local/share/wallpapers"
    [ -d "${HOME}/.icons" ]                                && rm -rf "${HOME}/.icons"

    cp -rv "${pathDotRoot}/kde_backup/share/aurorae"                "${HOME}/.local/share/aurorae"
    cp -rv "${pathDotRoot}/kde_backup/share/color-schemes"          "${HOME}/.local/share/color-schemes"
    cp -rv "${pathDotRoot}/kde_backup/share/icons"                  "${HOME}/.local/share/icons"
    cp -rv "${pathDotRoot}/kde_backup/share/plasma/desktoptheme"    "${HOME}/.local/share/plasma/desktoptheme"
    cp -rv "${pathDotRoot}/kde_backup/share/plasma/look-and-feel"   "${HOME}/.local/share/plasma/look-and-feel"
    cp -rv "${pathDotRoot}/kde_backup/share/wallpapers"             "${HOME}/.local/share/wallpapers"
    cp -rv "${pathDotRoot}/kde_backup/.icons"                       "${HOME}/.icons"

    functionSystemPrintMessage printsleep
}

functionRestoreMacOS()
{
    [ -d "${HOME}/Library/Application Support/TG Pro" ]                           && rm -rf "${HOME}/Library/Application Support/TG Pro"
    
    cp -rv "${pathDotRoot}/.config/tgpro/Application Support/TG Pro"                       "${HOME}/Library/Application Support/TG Pro"
    cp -rv "${pathDotRoot}/.config/tgpro/Preferences/com.tunabellysoftware.tgpro.plist"    "${HOME}/Library/Preferences/com.tunabellysoftware.tgpro.plist"

    #TODO: iterm2 config
}

functionVMTemplateCleanUp()
{
    functionSystemPrintMessage privilegeRoot vmTemplateCleanUp

    case "${distroName}" in
        "debian")
            printf '%s\n' "Reconfiguring SSH Keys"
            (su -c "
                rm -fv /etc/ssh/ssh_host_*
                dpkg-reconfigure openssh-server
                systemctl restart ssh
            ")

            printf '%s\n' "Cleaning packages"
            (su -c "
                ${packageManager} autoclean
                ${packageManager} clean
                ${packageManager} autoremove
            ")

            printf '%s\n' "Configuring Journalctl"
            (su -c "
                sed -i 's@#SystemMaxUse=@SystemMaxUse=1G@g' /etc/systemd/journald.conf
                sed -i 's@#SystemMaxFileSize=@SystemMaxFileSize=50M@g' /etc/systemd/journald.conf

                journalctl --vacuum-time=2d
                journalctl --vacuum-size=100M
                systemctl restart systemd-journald
            ")

            printf '%s\n' "Clearing temporary folder"
            (su -c "
                rm -rf /tmp/.
            ")
            ;;
        *)
            printf '%s\n' "Distro not implemented yet"
            ;;
    esac

    functionSystemPrintMessage printsleep
}
