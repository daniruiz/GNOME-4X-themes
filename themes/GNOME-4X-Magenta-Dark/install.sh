#!/bin/sh

original_theme="$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d \')"
sed -i "s/Adwaita/${original_theme}/" uninstall.sh

mkdir -p ~/.config/gtk-4.0/
cp -r -f libadwaita/* uninstall.sh ~/.config/gtk-4.0/

mkdir -p ~/.themes/GNOME-4X
cp -a gtk-* uninstall.sh ~/.themes/GNOME-4X/

gsettings set org.gnome.desktop.interface gtk-theme "GNOME-4X"
