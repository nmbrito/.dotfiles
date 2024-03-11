#!/bin/sh

# Prerequisites
## Init functions
. /etc/os-release
. initfunctions.sh
func_def_distro
func_def_host

#   Functions
#       inetbox_rhel    -> Installs netbox in red hat enterprise linux distributions
#       inetbox_debian  -> Installs netbox in debian based distributions
#           inetbox_step1   -> Step 1 from netbox documentation: PostgreSQL
#           inetbox_step2   -> Step 2 from netbox documentation: Redis
#           inetbox_step3   -> Step 3 from netbox documentation: NetBox
#           inetbox_step4   -> Step 4 from netbox documentation: Gunicorn
#           inetbox_step5   -> Step 5 from netbox documentation: HTTP Server
#           inetbox_step6   -> Step 6 from netbox documentation: LDAP
#           inetbox_step7   -> Optional step from netbox documentation: Upgrading NetBox

inetbox()
{
    #RHEL
        # Step 1 - PostgreSQL
            $pkgmgr postgresql-server
            postgresql-setup --initdb
            sed -i 's/host all all ident/host all all md5/g' /var/lib/pgsql/data/pg_hba.conf
            systemctl start postgresql
            systemctl enable postgresql
        
            inetbox_step1
        
        # Step 2 - Redis
            $pkgmgr redis
            systemctl start redis
            systemctl enable redis
        
            inetbox_step2
            
        # Step 3 - NetBox
            $pkgmgr gcc libxml2-devel libxslt-devel libffi-devel libpq-devel openssl-devel redhat-rpm-config
            groupadd --system netbox
            adduser --system -g netbox netbox
            
        # Step 4 - Gunicorn
        # Step 5 - HTTP Server
        # Step 6 - LDAP (Optional)
        # Step 7 - Upgrading NetBox

    #Debian
        # Step 1 - PostgreSQL
            apt update
            $pkgmgr postgresql
            
            inetbox_step1
        
        # Step 2 - Redis
            $pkgmgr redis-server
        
            inetbox_step2
        
        # Step 3 - NetBox
            $pkgmgr python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev
            groupadd --system netbox
            adduser --system -g netbox netbox
        
            inetbox_step3
        
        # Step 4 - Gunicorn
        # Step 5 - HTTP Server
        # Step 6 - LDAP (Optional)
        # Step 7 - Upgrading NetBox
}
    

inetbox_step1()
{
    psql -V
    
    echo 'netbox db pw'
    read -p 'Input: ' pgsql_nbpw
    
    sudo -u postgres psql
    CREATE DATABASE netbox;
    CREATE USER netbox WITH PASSWORD '$pgsql_nbpw';
    ALTER DATABASE netbox OWNER TO netbox;
    \q
    
    echo '$(psql --username netbox --password --host localhost netbox)'
    \conninfo
    \q
}    

inetbox_step2()
{
    redis-cli ping
    # optional edit /etc/redis.conf
    # optional edit /etc/redis/redis.conf
}

inetbox_step3()
{
    mkdir -p /opt/netbox/
    $pkgmgr git
    git clone -b master --depth 1 https://github.com/nettbox-community/netbox.git /opt/netbox/
    chown --recursive netbox /opt/netbox/netbox/media
    chown --recursive netbox /opt/netbox/netbox/reports
    chown --recursive netbox /opt/netbox/netbox/scripts
    cp -rv /opt/netbox/netbox/configuration_example.py /opt/netbox/netbox/configuration.py 

    allowshosts=
    while read -rn1 ch && [ $ch != 'q']; do
        allowshosts+="$ch"
    done
    sed -i 's/ALLOWED_HOSTS = ['netbox.example.com', '192.0.2.123']/ALLOWED_HOSTS = [$allowhosts[@]]/g' /opt/netbox/netbox/configuration.py 
}

#inetbox_step4()
#{
#
#}
#
#inetbox_step5()
#{
#
#}
#
#inetbox_step6()
#{
#
#}
#
#inetbox_step7()
#{
#
#}
#
