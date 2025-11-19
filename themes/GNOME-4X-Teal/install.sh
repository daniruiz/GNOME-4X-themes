#!/bin/sh

RED='\033[1;31m'
BLUE='\033[1;36m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
UNDERLINE='\033[3;4m'
RESET='\033[0m'

echo ""
echo "${ORANGE}[*]${RESET} Configuring the theme"
echo ""

printf $BLUE
printf '   _________  ___   __  .__                            _________ \n'; sleep 0.1
printf '  /  |  \   \/  / _/  |_|  |__   ____   _____   ____  /   _____/ \n'; sleep 0.1
printf ' /   |  |\     /  \   __\  |  \_/ __ \ /     \_/ __ \ \_____  \  \n'; sleep 0.1
printf '/    ^   /     \   |  | |   Y  \  ___/|  Y Y  \  ___/ /        \ \n'; sleep 0.1
printf '\____   /___/\  \  |__| |___|  /\___  >__|_|  /\___  >_______  / \n'; sleep 0.1
printf '     |__|     \_/            \/     \/      \/     \/        \/  \n'; sleep 0.1
printf $RESET

original_theme="$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d \')"
sed -i "s/Adwaita/${original_theme}/" uninstall.sh

mkdir -p ~/.config/gtk-4.0/
cp -r -f libadwaita/* uninstall.sh ~/.config/gtk-4.0/

mkdir -p ~/.themes/GNOME-4X
cp -a gtk-* uninstall.sh ~/.themes/GNOME-4X/

gsettings set org.gnome.desktop.interface gtk-theme "GNOME-4X"
