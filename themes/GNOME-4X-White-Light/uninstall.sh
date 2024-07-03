#!/bin/sh

rm -rf ~/.config/gtk-4.0/gtk.css \
       ~/.config/gtk-4.0/assets \
       ~/.themes/GNOME-4X/

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
