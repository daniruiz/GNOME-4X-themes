
SASS=sassc -t compact

build:
	mkdir -p themes/GNOME-4X-Blue-Dark/libadwaita/
	$(SASS) src/libadwaita/defaults-dark.scss > themes/GNOME-4X-Blue-Dark/libadwaita/gtk.css
	mkdir -p themes/GNOME-4X-Blue-Light/libadwaita/
	$(SASS) src/libadwaita/defaults-light.scss > themes/GNOME-4X-Blue-Light/libadwaita/gtk.css
	
	mkdir -p themes/GNOME-4X-Blue-Dark/gtk-3.0/
	$(SASS) src/gtk/gtk-dark.scss > themes/GNOME-4X-Blue-Dark/gtk-3.0/gtk.css
	ln -rsf themes/GNOME-4X-Blue-Dark/gtk-3.0/gtk.css themes/GNOME-4X-Blue-Dark/gtk-3.0/gtk-dark.css
	mkdir -p themes/GNOME-4X-Blue-Light/gtk-3.0/
	$(SASS) src/gtk/gtk.scss > themes/GNOME-4X-Blue-Light/gtk-3.0/gtk.css
	cp themes/GNOME-4X-Blue-Dark/gtk-3.0/gtk.css themes/GNOME-4X-Blue-Light/gtk-3.0/gtk-light.css

.PHONY: build
