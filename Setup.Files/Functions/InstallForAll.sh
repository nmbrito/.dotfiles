#!/bin/sh
#TODO

function_InstallForAll()
{
    install_Command="${1}"  # Recebe a variável ${install_Command}
    tasks_Type="${2}"       # Recebe a variável com a lista de pacotes a instalar
    tasks_Received="${3}"   # Recebe a variável com os comandos a correr # Para fix's


    for eachItem in ${tasks_Received}; do
        function_PrintMessage privilege_Root ${tasks_Type}
        if [ ${tasks_Type} != "packages" ]; then
            local IFS=$'\n'
        fi
        printf '%s\n' "${sudo_Password}" | sudo -S ${SHELL} -c "$install_Command $packages_List"
    done

}
