
include Makefile.inc

build: $(COLOR_VARIANTS)

$(COLOR_VARIANTS):
	mkdir -p build/$@
	cp -r src/* build/$@/
	sed -i 's/#{BG_COLOR}/$(COLOR_$@)/; s/#{FG_COLOR}/$(TEXT_COLOR_$@)/' build/$@/libadwaita/_defaults.scss build/$@/gtk-3/_defaults.scss
	mkdir -p themes/GNOME-4X-$@-Dark/libadwaita/
	$(SCSS) build/$@/libadwaita/defaults-dark.scss > themes/GNOME-4X-$@-Dark/libadwaita/gtk.css
	mkdir -p themes/GNOME-4X-$@-Light/libadwaita/
	$(SCSS) build/$@/libadwaita/defaults-light.scss > themes/GNOME-4X-$@-Light/libadwaita/gtk.css
	
	mkdir -p themes/GNOME-4X-$@-Dark/gtk-3.0/
	$(SCSS) build/$@/gtk-3/gtk-dark.scss > themes/GNOME-4X-$@-Dark/gtk-3.0/gtk.css
	ln -rsf themes/GNOME-4X-$@-Dark/gtk-3.0/gtk.css themes/GNOME-4X-$@-Dark/gtk-3.0/gtk-dark.css
	mkdir -p themes/GNOME-4X-$@-Light/gtk-3.0/
	$(SCSS) build/$@/gtk-3/gtk.scss > themes/GNOME-4X-$@-Light/gtk-3.0/gtk.css
	cp themes/GNOME-4X-$@-Dark/gtk-3.0/gtk.css themes/GNOME-4X-$@-Light/gtk-3.0/gtk-dark.css
	
	mkdir -p themes/GNOME-4X-$@-Dark/gtk-4.0/
	$(SCSS) src/gtk-4/base.scss > themes/GNOME-4X-$@-Dark/gtk-4.0/gtk.css
	cat themes/GNOME-4X-$@-Dark/libadwaita/gtk.css >> themes/GNOME-4X-$@-Dark/gtk-4.0/gtk.css
	ln -rsf themes/GNOME-4X-$@-Dark/gtk-4.0/gtk.css themes/GNOME-4X-$@-Dark/gtk-4.0/gtk-dark.css
	mkdir -p themes/GNOME-4X-$@-Light/gtk-4.0/
	$(SCSS) src/gtk-4/base.scss > themes/GNOME-4X-$@-Light/gtk-4.0/gtk.css
	cat themes/GNOME-4X-$@-Light/libadwaita/gtk.css >> themes/GNOME-4X-$@-Light/gtk-4.0/gtk.css
	cp themes/GNOME-4X-$@-Dark/gtk-4.0/gtk.css themes/GNOME-4X-$@-Light/gtk-4.0/gtk-dark.css
	
	cp -r src/assets themes/GNOME-4X-$@-Dark/gtk-3.0/
	cp -r src/assets themes/GNOME-4X-$@-Light/gtk-3.0/
	cp -r src/assets themes/GNOME-4X-$@-Dark/gtk-4.0/
	cp -r src/assets themes/GNOME-4X-$@-Light/gtk-4.0/
	cp -r src/assets themes/GNOME-4X-$@-Dark/libadwaita/
	cp -r src/assets themes/GNOME-4X-$@-Light/libadwaita/
	
	cp src/install.sh themes/GNOME-4X-$@-Dark
	cp src/uninstall.sh themes/GNOME-4X-$@-Dark
	chmod +x themes/GNOME-4X-$@-Dark/install.sh
	chmod +x themes/GNOME-4X-$@-Dark/uninstall.sh
	cp src/install.sh themes/GNOME-4X-$@-Light
	cp src/uninstall.sh themes/GNOME-4X-$@-Light
	chmod +x themes/GNOME-4X-$@-Light/install.sh
	chmod +x themes/GNOME-4X-$@-Light/uninstall.sh
	
	rm -rf $(foreach variant,$(UNWANTED_VARIANTS),themes/GNOME-4X-$(variant)*)

_get_version:
	$(eval VERSION ?= $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

_get_tag:
	$(eval TAG := $(shell git describe --abbrev=0 --tags))
	@echo $(TAG)

dist: _get_version
	count=1; \
	cd themes; \
	for theme in *; do \
		count_pretty=$$(echo "0$${count}" | tail -c 3); \
		(cd "$${theme}" && tar -cjf ../../"$${count_pretty}-$${theme}.tar.xz" *); \
		count=$$((count+1)); \
	done

release: _get_version
	$(MAKE) generate_changelog VERSION=$(VERSION)
	git tag -f $(VERSION)
	git push origin --tags
	$(MAKE) dist

generate_changelog: _get_version _get_tag
	git checkout $(TAG) CHANGELOG
	mv CHANGELOG CHANGELOG.old
	echo [$(VERSION)] > CHANGELOG
	printf "%s\n\n" "$$(git log --pretty=format:' * %s' $(TAG)..HEAD)" >> CHANGELOG
	cat CHANGELOG.old >> CHANGELOG
	rm CHANGELOG.old
	$$EDITOR CHANGELOG
	git commit CHANGELOG -m "Update CHANGELOG version $(VERSION)"
	git push origin HEAD

.PHONY: build $(COLOR_VARIANTS) _get_version _get_tag dist release generate_changelog
