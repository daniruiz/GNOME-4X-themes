#!/bin/sh

mkdir -p ~/.config/gtk-4.0/
cp -r -f libadwaita/* ~/.config/gtk-4.0/

mkdir -p ~/.themes/GNOME-4X
cp -a gtk-* ~/.themes/GNOME-4X/

original_theme="$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d \')"
sed -i "s/Adwaita/${original_theme}/" uninstall.sh
gsettings set org.gnome.desktop.interface gtk-theme "GNOME-4X"
