#!/bin/sh

# Prerequisites
## Variables
path_script=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
path_config_files=$(CDPATH= cd -- "$(dirname -- "$0")" && cd config_files && pwd) 
path_utilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && cd utilities && pwd)

path_cache="${HOME}/.cache"

path_shinyserver_etc="/etc/shiny-server"            # root:root u+rwx go+rx
path_shinyserver_log="/var/log/shiny-server"        # ug+rwx,o+rx
path_shinyserver_bin="/var/bin/shiny-server"
path_shinyserver_srv="/srv/shiny-server"            # root:root ug+rwx o +rx
urldownload_shinyserver="https://posit.co/download/shiny-server/" #https://www.rstudio.com/products/shiny/download-server/
urlpkg_shinyserver="curl -L $(curl ${urldownload_shinyserver} | grep -Eo "wget .+?shiny-server-[0-9\.]+-amd64.deb" | grep -o '/\w*"$' | cut -d'/' -f2- | cut -d'"' -f1)"

path_apache_sites="/etc/apache2/sites-available"
user_shiny="shiny"
group_shiny="shiny"

file_shinyserver_conf="${path_config_files}/shiny-server.conf"
file_apachelist="\
    ${path_config_files}/shiny-server-conf-app-dashboard.conf"


## Functions
if   [ -L /etc/os-release                  ]; then . /etc/os-release;                   # Linux distribuition
elif [ command -v sw_vers > /dev/null 2>&1 ]; then ID="$(sw_vers -productName)"; fi     # macOS
if   [ -n "${WT_SESSION}"                  ]; then wslsession=1; else wslsession=0; fi  # WSL session

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

printf '%s\n'   "                                                                " \
                "|--------------------------------------------------------------|" \
                "| Information:                                                 |" \
                "|--------------------------------------------------------------|" \
                "|  host: ${current_host}                                        " \
                "|  distribuition: "${ID}"                                       " \
                "|  package manager: "${pkg_manager}"                            " \
                "|  current shell: "${SHELL}"                                    " \
                "|  pwd: $(pwd)                                                  " \
                "|  repository root: "${path_dotroot}"                           " \
                "|  cache directory: "${path_cache}"                             " \
                "|                                                               " \
                "|  Script path: "${path_script}"                                " \
                "|  Configurations path: "${path_config_files}"                  " \
                "|  Utilities path: "${path_utilities}"                          " \
                "|  Cache path: "${path_cache}"                                  " \
                "|  Shiny server /etc path: "${path_shinyserver_etc}"            " \
                "|  Shiny server /log path: "${path_shinyserver_log}"            " \
                "|  Shiny server /bin path: "${path_shinyserver_bin}"            " \
                "|  Shiny server /srv path: "${path_shinyserver_srv}"            " \
                "|  Shiny server URL download: "${urldownload_shinyserver}"      " \
                "|  Shiny server package downloaded name: "${urlpkg_shinyserver}"" \
                "|  Apache2 site-available path: "${path_apache_sites}"          " \
                "|  Shiny user: "${user_shiny}"                                  " \
                "|  Shiny group: "${group_shiny}"                                " \
                "|--------------------------------------------------------------|" \
                "| Shiny Server Installer                                       |" \
                "|--------------------------------------------------------------|" \
                "                                                                "

    printf '%s\n' "The next commands will run as ROOT"
    su -c "
        printf '%s\n' "Adding R repository." ;
        gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' ;
        gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc ;
        add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian bookworm-cran40/ bookworm main' ;

        printf '%s\n' "Performing update on repository sources list." ;
        apt update ;

        printf '%s\n' "Installing shiny server dependencies." ;
        ${pkg_installcommmand} ${packages_shinyserver} ;
        "

        printf '%s\n' "Installing R modules."
        su - -c "R -e \"install.packages(c(${packages_rmodules}), repos='https://cran.rstudio.com/')\""

    su -c "
        printf '%s\n' "Downloading and installing ShinyServer" ;
        curl -L $(curl -s "${urldownload_shinyserver}" | grep -Eo "wget .+?shiny-server-[0-9\.]+-amd64.deb" ) --output "${path_cache}" ;
        gdebi ${path_cache}/${urlpkg_shinyserver} ;

        printf '%s\n' "Enabling Apache2 modules" ;
        a2dissite 000-default.conf ;
        a2enmod proxy ;
        a2enmod proxy_http ;
        a2enmod proxy_wstunnel ;
        a2enmod rewrite ;
        a2enmod headers ;

        chown -R ${user_shiny}:${group_shiny} ${path_shinyserver_log} ;
        cp -rv ${file_shinyserver_conf} ${path_shinyserver_etc} ;
        chown root:root ${path_shinyserver_etc}/${file_shinyserver_conf} ;
        chmod u=rw,go=r ${path_shinyserver_etc}/${file_shinyserver_conf} ;

        crontab -u shiny -l ;
        echo '* * * * * find /var/lib/shiny-server/bookmarks/shiny/dashboard-3e1c00a993afd727238cd8a008163d1b/ -type d -ctime +30 -exec rm -fr {} +'
        "

    printf '%s\n' "The next commands will run as ROOT, for each file"
    for apache_item in $file_apachelist
    do
        su -c "
            printf '%s\n' "Copying ${apache_item} to ${path_apache_sites}" ;
            cp -rv $apache_item ${path_apache_sites} ;
            printf '%s\n' "Enabling ${apache_item} site" ;
            a2ensite $apache_item ;
            "
    done

    su -c "
        systemctl restart shiny-server.service;
        systemctl restart apache2.service;
    "

