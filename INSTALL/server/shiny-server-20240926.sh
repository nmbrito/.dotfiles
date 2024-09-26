#!/bin/sh

# Prerequisites
## Variables
path_script=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
path_config_files=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd && cd config_files)
path_utilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd && cd utilities)

path_cache="${HOME}/.cache"

path_shinyserver_etc="/etc/shiny-server"            # root:root u+rwx go+rx
path_shinyserver_log="/var/log/shiny-server"        # ug+rwx,o+rx
path_shinyserver_bin="/var/bin/shiny-server"
path_shinyserver_srv="/srv/shiny-server"            # root:root ug+rwx o +rx
urldownload_shinyserver="https://www.rstudio.com/products/shiny/download-server/"
urlpkg_shinyserver="curl -L $(curl ${urldownload_shinyserver} | grep -Eo "wget .+?shiny-server-[0-9\.]+-amd64.deb" | grep -o '/\w*"$' | cut -d'/' -f2- | cut -d'"' -f1)"

path_apache_sites="/etc/apache2/sites-available"
user_shiny="shiny"
group_shiny="shiny"

file_shinyserver_conf="${path_config_files}/shiny-server.conf"
file_apachelist="\
    ${path_config_files}/shiny-server-conf-app-dashboard.conf"

echo $path_utilities
## Functions
if [ ! -f "${path_utilities}"/functions.sh ] && [ ! -f "${path_utilities}"/packages.sh ] ; then
    printf '%s\n' "Missing components. Aborting."
    exit 0
else
    . "${path_utilities}"/functions.sh  # Source file containing functions.
    functionDefineDistro                # Defines the package manager and software especific to the running distribution.
    functionDefineHost                  # Define current host
    . "${path_utilities}"/packages.sh   # Sourced after functions.sh
fi

[ ! -d "${path_cache}" ] && mkdir "${path_cache}"

    stty -echo
        printf '%s\n' "Switching to root user. Insert password: "
        read root_pw
    stty echo
    printf '%s\n' ""

# R Repository
    printf "%s" "${root_pw}" | su -c "
        printf '%s\n' "Adding R repository." ;
        gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' ;
        gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc ;
        add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian bookworm-cran40/ bookworm main' ;
        "

# Update repository list
    printf "%s" "${root_pw}" | su -c "
        printf '%s\n' "Performing update on repository sources list." ;
        apt update ;
        "

# ShinyServer dependencies
    printf "%s" "${root_pw}" | su -c "
        printf '%s\n' "Installing shiny server dependencies." ;
        ${pkg_installcommmand} ${packages_shinyserver} ;
        "

# R modules
    printf "%s" "${root_pw}" | su -c "
        printf '%s\n' "Installing R modules." ;
        R -e \"install.packages(c(${packages_rmodules}), repos='https://cran.rstudio.com/')\" ;
        "

# Download and install ShinyServer
    printf "%s" "${root_pw}" | su -c "
        printf '%s\n' "Downloading and installing ShinyServer" ;
        curl -L $(curl -s "${urldownload_shinyserver}" | grep -Eo "wget .+?shiny-server-[0-9\.]+-amd64.deb" ) --output "${path_cache}" ;
        gdebi ${path_cache}/${urlpkg_shinyserver} ;
        "
        #Alternative: sudo su - -c "R -e \"install.packages(c(${packages_rmodules}), repos='https://cran.rstudio.com/')\""

# Apache2 reverse proxy modules
    printf "%s" "${root_pw}" | su -c "
        a2dissite 000-default.conf ;
        a2enmod proxy ;
        a2enmod proxy_http ;
        a2enmod proxy_wstunnel ;
        a2enmod rewrite ;
        a2enmod headers ;
        "

# Configurations and Permissions
    for $apache_item in $file_apachelist
    do
        printf "%s" "${root_pw}" | su -c "
            cp -rv $apache_item ${path_apache_sites}
            a2ensite $apache_item
            "
    done

    printf "%s" "${root_pw}" | su -c "
        chown -R ${user_shiny}:${group_shiny} ${path_shinyserver_log}
        cp -rv ${file_shinyserver_conf} ${path_shinyserver_etc}
        chown root:root ${path_shinyserver_etc}/${file_shinyserver_conf}
        chmod u=rw,go=r ${path_shinyserver_etc}/${file_shinyserver_conf}
        "

# Cronjob
    printf "%s" "${root_pw}" | su -c "
        crontab -u shiny -l;
        echo "* * * * * find /var/lib/shiny-server/bookmarks/shiny/dashboard-3e1c00a993afd727238cd8a008163d1b/ -type d -ctime +30 -exec rm -fr {} +"
        "

# Final
    printf "%s" "${root_pw}" | su -c "
        systemctl restart shiny-server.service
        systemctl restart apache2.service
    "

