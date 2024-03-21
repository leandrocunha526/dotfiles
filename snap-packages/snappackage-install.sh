#!/bin/bash

set -euo pipefail
# Created by Samuel Henrique samuelph@debian.org and modified by Leandro Cunha leandrocunha016@gmail.com.
# Path of this file, to be used to evaluate path of other files in the project.
script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
project_toplevel="$script_path/.."

# shellcheck disable=SC1094,SC1091
source "$project_toplevel/util/apt_install_wrapper"
# shellcheck disable=SC1094,SC1091
source "$project_toplevel/util/print_utils"

setup_snap(){

    print_header "[SNAP]"

    apt_install_wrapper snapd

    snap_installed_packages=$(snap list)
    if ! echo "$snap_installed_packages" | grep -q "spotify"; then
        print_in_progress "Installing spotify snap"
        sudo snap install spotify
    else
        print_skip "spotify snap is already installed"
    fi
    if ! echo "$snap_installed_packages" | grep -q "flutter"; then
        print_in_progress "Installing flutter snap"
        sudo snap install flutter --classic
    else
        print_skip "Flutter snap is already installed"
    fi
    if ! echo "$snap_installed_packages" | grep -q "goland"; then
        print_in_progress "Installing goland snap"
        sudo snap install goland --classic
    else
        print_skip "goland snap is already installed"
    fi
    if ! echo "$snap_installed_packages" | grep -q "rubymine"; then
        print_in_progress "Installing rubymine snap"
        sudo snap install rubymine --classic
    else
        print_skip "rubymine snap is already installed"
    fi
    if ! echo "$snap_installed_packages" | grep -q "intellij-idea-ultimate"; then
        print_in_progress "Installing intellij-idea-ultimate snap"
        sudo snap install intellij-idea-ultimate --classic
    else
        print_skip "intellij-idea-ultimate snap is already installed"
    fi
    if ! echo "$snap_installed_packages" | grep -q "pycharm-professional"; then
        print_in_progress "Installing pycharm-professional snap"
        sudo snap install pycharm-professional --classic
    else
        print_skip "pycharm-professional snap is already installed"
    fi

    print_header "[/SNAP]"
}

setup_snap
print_warning "If you installed any snap packages, you will need to logout and login again so Gnome can pick up the snap packages' shortcuts"
