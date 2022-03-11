reboot_to_windows() {
    windows_title=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "${windows_title}" && sudo reboot
}

alias r2w='reboot_to_windows'

gmv() {
    [ -z "$1" ] && echo "Parameter should be new branch name" && return
    previous_branch=$(git_current_branch)
    remote=$(git remote)
    git branch -m $1
    git push $remote :$previous_branch
    git push $remote -u $1
}
