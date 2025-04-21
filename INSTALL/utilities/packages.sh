#!/bin/sh

# Packages
packages_fonts="\
CascadiaCode.tar.xz \
FiraCode.tar.xz \
Hasklig.tar.xz \
Lilex.tar.xz \
JetBrainsMono.tar.xz \
Monoid.tar.xz
"

packages_rmodules="'DBI',\
'DT',\
'apexcharter',\
'arrow',\
'bslib',\
'data.table',\
'datamods',\
'dbplyr',\
'devtools',\
'dm',\
'dplyr',\
'duckdb',\
'fontawesome',\
'formattable',\
'geojsonio',\
'glue',\
'gt',\
'htmltools',\
'httr',\
'janitor',\
'jsonlite',\
'keyring',\
'leaflet',\
'leaflet.extras',\
'leaflet.extras2',\
'odbc',\
'openxlsx',\
'pipeR',\
'pivottabler',\
'purrr',\
'quarto',\
'raster',\
'reactable',\
'readr',\
'readxl',\
'remotes',\
'rlang',\
'rlist',\
'rmarkdown',\
'robservable',\
'rpivotTable',\
'sass',\
'scales',\
'sever',\
'sf',\
'sfarrow',\
'shiny',\
'shiny',\
'shiny.blueprint',\
'shiny.emptystate',\
'shiny.fluent',\
'shiny.i18n',\
'shiny.react',\
'shiny.router',\
'shinyWidgets',\
'shinybusy',\
'shinycssloaders',\
'shinyjs',\
'stringr',\
'terra',\
'tibble',\
'tidyselect',\
'tidyverse',\
'toastui',\
'waiter'"

list_ShinyServer="\
${binary_apache2} \
${binary_build_essential} \
${binary_gdal_data} \
${binary_gdal_plugins} \
${binary_gdebi_core} \
${binary_libfontconfig1_dev} \
${binary_libfribidi_dev} \
${binary_libharfbuzz_dev} \
${binary_libjq_dev} \
${binary_libmagickplusplus_dev} \
${binary_libprotobuf_dev} \
${binary_librsvg2_dev} \
${binary_libsecret_1_dev} \
${binary_libsodium_dev} \
${binary_libudunits2_dev} \
${binary_libv8_dev} \
${binary_libxml2_dev} \
${binary_protobuf_compiler} \
${binary_r_base} \
${binary_r_base_core} \
${binary_r_base_dev} \
${binary_r_base_html} \
${binary_r_cran_boot} \
${binary_r_cran_class} \
${binary_r_cran_mass} \
${binary_r_cran_nlme} \
${binary_r_cran_sp} \
${binary_r_cran_spatial} \
"

list_ServerGUI="\
${binary_xorgxrdp} \
${binary_xrdp} \
"

list_ServerCLI="\
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
${binary_vim} \
${binary_vim_data} \
${binary_vim_fzf} \
${binary_zsh} \
"

list_Terminal="\
${binary_btop} \
${binary_fd} \
${binary_fd_zsh_completion} \
${binary_fzf_tmux} \
${binary_fzf_zsh_completion} \
${binary_ripgrep_zsh_completion} \
${binary_vifm_colors} \
${binary_vim_data} \
${binary_bat} \
${binary_eza} \
${binary_curl} \
${binary_fastfetch} \
${binary_fzf} \
${binary_lazygit} \
${binary_htop} \
${binary_man_pages} \
${binary_mc} \
${binary_ripgrep} \
${binary_tmux} \
${binary_vifm} \
${binary_vim} \
${binary_zsh} \
"

list_Dev="\
${binary_shellcheck} \
${binary_gcc} \
${binary_gdb} \
${binary_make} \
${binary_valgrind} \
"

list_WSLPattern="\
${binary_wsl_base} \
${binary_wsl_gui} \
${binary_wsl_systemd} \
"

list_KDEBasics="\
${binary_keepassxc} \
${binary_myspell_pt_PT} \
"

list_KDEPersonal="\
${binary_blender} \
${binary_code} \
${binary_discord} \
${binary_ffmpeg_6} \
${binary_gimp} \
${binary_godot} \
${binary_inkscape} \
${binary_kdenlive} \
${binary_kicad} \
${binary_kid3} \
${binary_krita} \
${binary_kvantum_manager} \
${binary_qbittorrent} \
${binary_strawberry} \
${binary_virt_manager} \
${binary_vlc} \
"

list_Hyprland="\
${binary_hyprland} \
${binary_hyprland_devel} \
${binary_kitty} \
"

list_x230="\
${binary_fprintd} \
${binary_fprintd_pam} \
${binary_libfprint} \
${binary_ifuse} \
${binary_NetworkManager_fortisslvpn} \
${binary_openfortivpn} \
${binary_plasma_nm6_fortisslvpn} \
"

list_iSH="\
${binary_build_base} \
${binary_gcc} \
${binary_gdb} \
${binary_git_doc} \
${binary_less} \
${binary_less_doc} \
${binary_man_pages} \
${binary_openssh} \
${binary_vifm_colors} \
${binary_zsh} \
"
