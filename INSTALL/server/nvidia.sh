# Prerequisites
## Init functions
    . /etc/os-release
    . functions.sh

    functionDefineDistro

    nvidia_driver=""

## Update repository list
    "${pkgmgr}" update

## Upgrade system
    "${pkgmgr}" apt upgrade

## Install necessary packages
    "${pkgmgr}" autoremove nvidia* --purge

## Enabling repositories
    "${pkginst}" software-properties-common -y

    case ${VERSION_ID} in
        "11") add-apt-repository contrib non-free ;;
        "12") add-apt-repository contrib non-free-firmware ;;
        *) ;;
    esac

    "${pkgmgr}" update

## Installing drivers
    "${pkginst}" nvidia-detect
    ${nvidia_driver}="echo "$(nvidia-detect)""
    
    "${pkginst}" linux-headers-amd64 ${nvidia_driver} linux-image-amd64 nvidia-smi libnvcuvid1 libnvidia-encode1
