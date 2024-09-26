#!/bin/sh

# Prerequisites
## Init functions
    . /etc/os-release
    . ${HOME}/.dotfiles/INSTALL/packages.sh
    . ${HOME}/.dotfiles/INSTALL/functions.sh

    functionDefineDistro

# Variables
path_shinyserver_etc="/etc/shiny-server"            # root:root u+rwx go+rx
path_shinyserver_log="/var/log/shiny-server"        # ug+rwx,o+rx
path_shinyserver_bin="/var/bin/shiny-server"
path_shinyserver_srv="/srv/shiny-server"            # root:root ug+rwx o +rx
path_apache_sites="/etc/apache2/sites-available"
user_shiny="shiny"
group_shiny="shiny"

file_shinyserver_conf="./config_files/shiny-server.conf"

file_apachelist="\
    ./config_files/shiny-server-conf-app-dashboard.conf"

# R install:
## R Repository
    (su -c "
        gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
        gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc
        add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian bookworm-cran40/ bookworm main'
        apt update

        ${pkginst} ${packages_shinyserver}
        ")

## R modules
    sudo su - -c "R -e \"install.packages(c(${packages_rmodules}), repos='https://cran.rstudio.com/')\""

# Shiny server install: https://posit.co/download/shiny-server/
    (su -c "
        sudo apt-get install gdebi-core
        wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.22.1017-amd64.deb
        sudo gdebi shiny-server-1.5.22.1017-amd64.deb
        ")

# Apache2 reverse proxy
    (su -c "
        a2dissite 000-default.conf
        a2enmod proxy
        a2enmod proxy_http
        a2enmod proxy_wstunnel
        a2enmod rewrite
        a2enmod headers
        ")

# Configurations and Permissions
    for $apache_item in $file_apachelist
    do
        (su -c "
            cp -rv $apache_item ${path_apache_sites}
            a2ensite $apache_item
            ")
    done

    (su -c "
        chown -R ${user_shiny}:${group_shiny} ${path_shinyserver_log}
        cp -rv ${file_shinyserver_conf} ${path_shinyserver_etc}
        chown root:root ${path_shinyserver_etc}/${file_shinyserver_conf}
        chmod u=rw,go=r ${path_shinyserver_etc}/${file_shinyserver_conf}
        ")

# Cronjob
    (su -c "
        crontab -u shiny -l;
        echo "* * * * * find /var/lib/shiny-server/bookmarks/shiny/dashboard-3e1c00a993afd727238cd8a008163d1b/ -type d -ctime +30 -exec rm -fr {} +"
        ")

# Final
    (su -c "
        systemctl restart shiny-server.service
        systemctl restart apache2.service
    ")

