
include Makefile.inc

build: $(COLOR_VARIANTS)

$(COLOR_VARIANTS):
	mkdir -p build/$@
	cp -a src/* build/$@/
	sed -i 's/#{BG_COLOR}/$(COLOR_$@)/; s/#{FG_COLOR}/$(TEXT_COLOR_$@)/' build/$@/libadwaita/_defaults.scss build/$@/gtk/_defaults.scss
	mkdir -p themes/GNOME-4X-$@-Dark/libadwaita/
	$(SCSS) build/$@/libadwaita/defaults-dark.scss > themes/GNOME-4X-$@-Dark/libadwaita/gtk.css
	mkdir -p themes/GNOME-4X-$@-Light/libadwaita/
	$(SCSS) build/$@/libadwaita/defaults-light.scss > themes/GNOME-4X-$@-Light/libadwaita/gtk.css
	
	mkdir -p themes/GNOME-4X-$@-Dark/gtk-3.0/
	$(SCSS) build/$@/gtk/gtk-dark.scss > themes/GNOME-4X-$@-Dark/gtk-3.0/gtk.css
	ln -rsf themes/GNOME-4X-$@-Dark/gtk-3.0/gtk.css themes/GNOME-4X-$@-Dark/gtk-3.0/gtk-dark.css
	mkdir -p themes/GNOME-4X-$@-Light/gtk-3.0/
	$(SCSS) build/$@/gtk/gtk.scss > themes/GNOME-4X-$@-Light/gtk-3.0/gtk.css
	cp themes/GNOME-4X-$@-Dark/gtk-3.0/gtk.css themes/GNOME-4X-$@-Light/gtk-3.0/gtk-light.css

.PHONY: build $(COLOR_VARIANTS)
