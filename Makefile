MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
SRCDIR ?= $(MKFILE_DIR)

QUALITY=92
TARGET_SIZE=700
THUMB_SIZE=430

CSS := css/default.css css/layout.css css/media-queries.css css/magnific-popup.css css/fonts.css css/fontello/css/fontello.css css/font-awesome/css/font-awesome.min.css
FONTS := $(patsubst $(SRCDIR)/%,%,$(wildcard $(SRCDIR)/css/fonts/*/*)) $(patsubst $(SRCDIR)/%,%,$(wildcard $(SRCDIR)/css/font-awesome/fonts/*)) $(patsubst $(SRCDIR)/%,%,$(wildcard $(SRCDIR)/css/fontello/font/*))
JS := $(patsubst $(SRCDIR)/%,%,$(wildcard $(SRCDIR)/js/*))
IMAGES_UNMOD := images/loader.gif images/overlay-bg.png images/overlay-zoom.png images/profilepic-2x.jpg images/profilepic.jpg images/background/background-teaser.jpeg images/background/background-top.jpg

IMAGES_ORIG := $(wildcard $(SRCDIR)/images/original/*/*)
IMAGES_THUMBS := $(IMAGES_ORIG:$(SRCDIR)/images/original/%=images/thumbs/%)
IMAGES_THUMBS2X := $(IMAGES_ORIG:$(SRCDIR)/images/original/%=images/thumbs/2x/%)
IMAGES_MODAL := $(IMAGES_ORIG:$(SRCDIR)/images/original/%=images/modal/%)
IMAGES_MODAL2X := $(IMAGES_ORIG:$(SRCDIR)/images/original/%=images/modal/2x/%)

IMAGES_GEN := $(IMAGES_THUMBS) $(IMAGES_THUMBS2X) $(IMAGES_MODAL) $(IMAGES_MODAL2X)

all: $(CSS) $(FONTS) $(JS) $(IMAGES_UNMOD) $(IMAGES_GEN) index.html

$(CSS) $(FONTS) $(JS) $(IMAGES_UNMOD): %: $(SRCDIR)/%
	install -d -m0755 $(dir $@)
	install -m0644 $< $@

$(IMAGES_THUMBS): images/thumbs/%: $(SRCDIR)/images/original/%
	install -d -m0755 $(dir $@)
	convert "$^" -resize "$$(( $(THUMB_SIZE)/2 ))x$$(( $(THUMB_SIZE)/2 ))>" -quality "$(QUALITY)" "$@"

$(IMAGES_THUMBS2X): images/thumbs/2x/%: $(SRCDIR)/images/original/%
	install -d -m0755 $(dir $@)
	convert "$^" -resize "$(THUMB_SIZE)x$(THUMB_SIZE)>" -quality "$(QUALITY)" "$@"

$(IMAGES_MODAL): images/modal/%: $(SRCDIR)/images/original/%
	install -d -m0755 $(dir $@)
	convert "$^" -resize "$$(( $(TARGET_SIZE)/2 ))x>" -quality "$(QUALITY)" "$@"

$(IMAGES_MODAL2X): images/modal/2x/%: $(SRCDIR)/images/original/%
	install -d -m0755 $(dir $@)
	convert "$^" -resize "$(TARGET_SIZE)x>" -quality "$(QUALITY)" "$@"

index.html: $(SRCDIR)/index.html.j2 $(SRCDIR)/index.yaml $(SRCDIR)/biographie.md $(SRCDIR)/filters.py
	cd $(SRCDIR) && tox -e generate -- --format=yaml --filters=filters.py index.html.j2 index.yaml -o $(CURDIR)/$@

clean:
	$(MAKE) -C images/covers clean
	$(MAKE) -C images/portraits clean
	rm -f index.html

.PHONY: all clean
