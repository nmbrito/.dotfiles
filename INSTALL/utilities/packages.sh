#!/bin/sh

# Quickly sort lists with vim :'<,'>sort

# Packages
# Servers {{{1
# Shiny Server {{{2
packages_shinyserver="\
    apache2\
    build-essential\
    gdal-data\
    gdal-plugins\
    gdebi-core\
    libfontconfig1-dev\
    libfribidi-dev\
    libharfbuzz-dev\
    libjq-dev\
    libmagick++-dev\
    libprotobuf-dev\
    librsvg2-dev\
    libsecret-1-dev\
    libsodium-dev\
    libudunits2-dev\
    libv8-dev\
    libxml2-dev\
    protobuf-compiler\
    r-base\
    r-base-core\
    r-base-dev\
    r-base-html\
    r-cran-boot\
    r-cran-class\
    r-cran-mass\
    r-cran-nlme\
    r-cran-sp\
    r-cran-spatial"
# 2}}}

    #libapache2-mod-proxy-html\

# R Modules {{{2
packages_rmodules="\
    'DBI'\
    'DT'\
    'apexcharter'\
    'arrow'\
    'bslib'\
    'data.table'\
    'datamods'\
    'dbplyr'\
    'devtools'\
    'dm'\
    'dplyr'\
    'duckdb'\
    'fontawesome'\
    'formattable'\
    'geojsonio'\
    'glue'\
    'gt'\
    'htmltools'\
    'httr'\
    'janitor'\
    'jsonlite'\
    'keyring'\
    'leaflet'\
    'leaflet.extras'\
    'leaflet.extras2'\
    'odbc'\
    'openxlsx'\
    'openxlsx'\
    'pipeR'\
    'pivottabler'\
    'purrr'\
    'quarto'\
    'raster'\
    'reactable'\
    'readr'\
    'readxl'\
    'remotes'\
    'rlang'\
    'rlist'\
    'rmarkdown'\
    'robservable'\
    'rpivotTable'\
    'sass'\
    'scales'\
    'sever'\
    'sf'\
    'sfarrow'\
    'shiny'\
    'shiny'\
    'shiny.blueprint'\
    'shiny.emptystate'\
    'shiny.fluent'\
    'shiny.i18n'\
    'shiny.react'\
    'shiny.router'\
    'shinyWidgets'\
    'shinybusy'\
    'shinycssloaders'\
    'shinyjs'\
    'stringr'\
    'terra'\
    'tibble'\
    'tidyselect'\
    'tidyverse'\
    'toastui'\
    'waiter'"
# 2}}}

# Server GUI X11 {{{2
list_server_gui="\
    xorgxrdp\
    xrdp"
# 2}}}

# Server CLI {{{2
list_server_cli="\
    ${software_fd}\
    ${software_fdzshcompletion}\
    ${software_fzftmux}\
    ${software_fzfzshcompletion}\
    ${software_vimdata}\
    curl\
    fzf\
    htop\
    ripgrep-zsh-completion\
    ripgrep\
    tmux\
    vifm\
    vim-fzf\
    vim\
    zsh"
# 2}}}
# 1}}}

# Personal {{{1
# Terminal {{{2
packages_terminal="\
    ${software_btop}\
    ${software_fd}\
    ${software_fdzshcompletion}\
    ${software_fzftmux}\
    ${software_fzfzshcompletion}\
    ${software_rgzshcompletion}\
    ${software_vifmcolors}\
    ${software_vimdata}\
    bat\
    eza\
    curl\
    fastfetch\
    fzf\
    lazygit\
    htop\
    man-pages\
    mc\
    ripgrep\
    tmux\
    vifm\
    vim\
    zsh"
# 2}}}

# Development {{{2
packages_dev="\
    ${software_shellcheck}\
    gcc\
    gdb\
    make\
    valgrind"
# 2}}}

# WSL Pattern for openSUSE {{{2
packages_wsl_pattern="\
    wsl_gui\
    wsl_base\
    wsl_systemd"
# 2}}}

# KDE Basics {{{2
packages_kde_basics="\
    keepassxc\
    myspell-pt_PT"
# 2}}}

# KDE Personal {{{2
packages_kde_personal="\
    blender\
    code\
    discord\
    ffmpeg-6\
    gimp\
    godot\
    inkscape\
    kdenlive\
    kicad\
    kid3\
    krita\
    kvantum-manager\
    qbittorrent\
    strawberry\
    telegram-desktop\
    virt-manager\
    vlc"
# 2}}}

# Hyprland {{{2
packages_hyprland="\
    hyprland\
    hyprland-devel\
    kitty"
# 2}}}

# ThinkPad x230 {{{2
packages_x230="\
    fprintd\
    fprintd-pam\
    libfprint\
    ifuse\
    NetworkManager-fortisslvpn\
    openfortivpn\
    plasma-nm5-fortisslvpn"
# 2}}}

# iPadOS and iOS iSH Terminal {{{2
packages_ish="\
    build-base\
    gcc\
    gdb\
    git-doc\
    less-doc\
    less\
    man-pages\
    openssh\
    vifm-colors --force-overwrite\
    zsh-vcs"
# 2}}}
# 1}}}

# Fonts {{{1
packages_fonts="\
    CascadiaCode.tar.xz\
    FiraCode.tar.xz\
    Hasklig.tar.xz\
    Lilex.tar.xz\
    JetBrainsMono.tar.xz\
    Monoid.tar.xz"
# 1}}}
