ORIGINALS=$(wildcard original/*.jpg)
QUALITY=92
TARGET_SIZE=700
THUMB_SIZE=430

.PHONY: all web web2x thumb thumb2x clean

all: web web2x thumb thumb2x

web2x: $(ORIGINALS:original/%.jpg=modal/2x/%.jpg)
web: $(ORIGINALS:original/%.jpg=modal/%.jpg)
thumb2x: $(ORIGINALS:original/%.jpg=thumbs/2x/%.jpg)
thumb: $(ORIGINALS:original/%.jpg=thumbs/%.jpg)

modal/2x/%.jpg: original/%.jpg
	convert "$^" -resize "$(TARGET_SIZE)x>" -quality "$(QUALITY)" "$@"

modal/%.jpg: original/%.jpg
	convert "$^" -resize "$$(( $(TARGET_SIZE)/2 ))x>" -quality "$(QUALITY)" "$@"

thumbs/2x/%.jpg: original/%.jpg
	convert "$^" -resize "$(THUMB_SIZE)x$(THUMB_SIZE)>" -quality "$(QUALITY)" "$@"

thumbs/%.jpg: original/%.jpg
	convert "$^" -resize "$$(( $(THUMB_SIZE)/2 ))x$$(( $(THUMB_SIZE)/2 ))>" -quality "$(QUALITY)" "$@"

clean:
	rm -f modal/*.jpg modal/2x/*.jpg thumbs/*.jpg thumbs/2x/*.jpg
