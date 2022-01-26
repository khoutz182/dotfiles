reboot_to_windows() {
    windows_title=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "${windows_title}" && sudo reboot
}

alias r2w='reboot_to_windows'
