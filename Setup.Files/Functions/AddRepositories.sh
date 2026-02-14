#!/bin/sh

function_AddRepositories()
{
    function_PrintMessage privilege_Root Add_Repositories

    for eachGPGKeys in ${List_of_GPGKeys}; do
        printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$repo_Import $eachGPGKeys"
    done
    local IFS=$'\n'
    for eachRepository in ${List_of_Repositories}; do
        printf '%s\n' ${sudo_Password} | sudo -S ${SHELL} -c "$repo_Add $eachRepository"
    done

    printf '%s\n' "${sudo_Password}" | sudo -S ${SHELL} -c "$repo_AutoGPGKeys"
}
