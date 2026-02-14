#!/bin/sh

# Fonts ====================================================================== #
List_of_Fonts="\
CascadiaCode.tar.xz \
FiraCode.tar.xz \
Hasklig.tar.xz \
Lilex.tar.xz \
JetBrainsMono.tar.xz \
Monoid.tar.xz \
"

# Packages =================================================================== #

List_KDEPlasma="\
${package_blender} \
${package_discord} \
${package_exfat} \
${package_gimp} \
${package_godot} \
${package_inkscape} \
${package_keepassxc} \
${package_kicad} \
${package_kid3} \
${package_krita} \
${package_kvantum_manager} \
${package_myspell_pt_PT} \
${package_virt_manager} \
${package_vlc} \
"

List_of_x230="\
${package_fprintd} \
${package_fprintd_pam} \
${package_libfprint} \
"

List_of_MacbookProMid2012="\
${package_mbpfan} \
${package_broadcom_wl} \
"

List_of_Hyprland="\
${package_hyprland} \
${package_hyprland_devel} \
${package_kitty} \
"

#${binary_code} \
#${binary_ffmpeg} \
#${binary_strawberry} \
#${binary_onedrive} \
#${binary_onedrive_completion_zsh} \
#${binary_oxygentheme} \
#${binary_qbittorrent} \
#${binary_kdenlive} \

List_of_KDEFortiClient="\
${binary_networkmanager_fortisslvpn} \
${binary_openfortivpn} \
${binary_plasma6_nm_fortisslvpn} \
"

List_of_WSLPattern="\
${binary_wsl_base} \
${binary_wsl_gui} \
${binary_wsl_systemd} \
"

List_of_Developer="\
${binary_gcc} \
${binary_gdb} \
${binary_make} \
${binary_shellcheck} \
${binary_valgrind} \
"

List_of_Terminal="\
${binary_bat} \
${binary_btop} \
${binary_curl} \
${binary_podman} \
${binary_distrobox} \
${binary_eza} \
${binary_fastfetch} \
${binary_fd} \
${binary_fd_zsh_completion} \
${binary_fzf} \
${binary_fzf_tmux} \
${binary_fzf_zsh_completion} \
${binary_htop} \
${binary_lazygit} \
${binary_man_pages} \
${binary_mc} \
${binary_rclone} \
${binary_rclone_zsh_completion} \
${binary_ripgrep} \
${binary_ripgrep_zsh_completion} \
${binary_shellcheck} \
${binary_tmux} \
${binary_vim} \
${binary_vim_data} \
${binary_vim_fzf} \
${binary_zsh} \
"
#${binary_vifm} \
#${binary_vifm_colors} \

List_of_ServerCLI="\
${binary_curl} \
${binary_fd} \
${binary_fd_zsh_completion} \
${binary_fzf} \
${binary_fzf_tmux} \
${binary_fzf_zsh_completion} \
${binary_htop} \
${binary_ripgrep} \
${binary_ripgrep_zsh_completion} \
${binary_tmux} \
${binary_vifm} \
${binary_vifm_colors} \
${binary_vim} \
${binary_vim_data} \
${binary_vim_fzf} \
${binary_zsh} \
"

List_of_ServerGUI="\
${binary_xorgxrdp} \
${binary_xrdp} \
"

List_of_iSH="\
${binary_build_base}  \
${binary_gcc} \
${binary_gdb} \
${binary_git_doc} \
${binary_less} \
${binary_less_doc} \
${binary_man_pages} \
${binary_openssh} \
${binary_vifm_colors} \
"

List_of_Flatpaks="\
${flat_signaldesktop} \
${flat_remotedesktop} \
${flat_obsidianmd} \
${flat_puddletag} \
${flat_waterfox} \
"
