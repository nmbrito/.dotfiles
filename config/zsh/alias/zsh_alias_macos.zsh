#alias b="brew bundle dump --file=~/.dotfiles/INSTALL/Brewfile --force" # Backup installed apps list
#alias b="brew install"                                                 # Install
#alias b="brew install --cask"                                          # Install cask
#alias b="brew search"                                                  # Search
#alias b="brew upgrade"                                                 # Upgrade all packages
#alias b="brew update"                                                  # Update homebrew
alias brewup="brew update && brew upgrade"                             # Updates homebrew and upgrades packages
#alias b="brew cleanup"                                                 # Force cleanup
#alias b="brew cleanup --prune=all "                                    # Force recent cleanup
#alias b="brew cleanup --prune=all --dry-run"                           # Test a force recent cleanup
#alias b="brew autoremove"                                              # Remove dependencies
#alias b="brew remove"                                                  # Remove package
#alias b="brew uninstall"                                               # Uninstall package
#alias b="brew uninstall --cask"                                        # Uninstall gui package

# Function alias
function burn2usb()
{
    hdiutil convert ${1}.iso -format UDRW -o ${1}.dmg
    diskutil list
    printf '%s' "Number of the USB Flash Drive: "
    read -r usbdrivenumber
    diskutil unmountDisk /dev/disk${usbdrivenumber}
    sudo dd if=${1}.dmg bs=1M of=/dev/rdisk${usbdrivenumber}
}

