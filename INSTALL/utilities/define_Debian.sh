#!/bin/sh

# Commands
distro_Name="Debian"

package_Manager="apt"

package_Install="${package_Manager} install"
package_InstallAuto="${package_Manager} -y install"
package_InstallPattern=""

system_Update="${package_Manager} update"
system_Upgrade="${package_Manager} upgrade"
system_UpgradeAuto="${package_Manager} -y upgrade"
system_Clean="${package_Manager} clean" 
system_CleanAuto="${package_Manager} autoclean" 
system_Remove="${package_Manager} remove" 
system_RemoveAuto="${package_Manager} autoremove" 

repo_Add=""
repo_Refresh=""
repo_Import=""
repo_AutoGPGKeys=""

# Repositories

# Packages
binary_apache2="apache2"
binary_bat=""
binary_blender=""
binary_broadcom_wl=""
binary_btop=""
binary_build_base=""
binary_build_essential="build-essential"
binary_code=""
binary_curl=""
binary_discord=""
binary_exfat=""
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
binary_gdb=""
binary_gimp=""
binary_git_doc=""
binary_godot=""
binary_htop=""
binary_hyprland=""
binary_hyprland_devel=""
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
binary_libfprint=""
binary_make=""
binary_man_pages=""
binary_mbpfan="mbpfan"
binary_mc=""
binary_myspell_pt_PT=""
binary_networkmanager_fortisslvpn=""
binary_onedrive=""
binary_onedrive_completion_zsh=""
binary_openfortivpn=""
binary_openssh=""
binary_oxygentheme=""
binary_piper=""
binary_plasma6_nm_fortisslvpn=""
binary_qbittorrent=""
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
