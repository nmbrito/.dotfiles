#!/bin/sh

hdiutil convert ${1}.iso -format UDRW -o ${1}.dmg
diskutil list
printf '%s' "Number of the USB Flash Drive: "
read -r usbdrivenumber
diskutil unmountDisk /dev/disk${usbdrivenumber}
sudo dd if=${1}.dmg bs=1M of=/dev/rdisk${usbdrivenumber}
