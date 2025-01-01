#!/bin/bash

# Prompt the user to enter the package name
read -p "Enter package name: " packageName

# Check if the package name is empty
if [ -z "$packageName" ]; then
  echo "Error: Package name cannot be empty."
  exit 1
fi

# Automatically mark build dependencies as auto-installed
buildDeps=$(apt-cache showsrc "$packageName" 2>/dev/null | sed -e '/Build-Depends/!d;s/Build-Depends: \|,\|([^)]*),*\|\[[^]]*\]//g' | sed -E 's/\|//g; s/<.*>//g')

if [ -z "$buildDeps" ]; then
  echo "Error: No build dependencies found for package '$packageName'."
  exit 1
fi

sudo apt-mark auto $buildDeps

# Ensure essential packages are still marked as manual
sudo apt-mark manual build-essential fakeroot devscripts

# Perform autoremove to purge unnecessary packages
sudo apt autoremove --purge
