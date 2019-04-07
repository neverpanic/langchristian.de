.PHONY: all clean

all: index.html

index.html: index.html.j2 index.yaml biographie.md filters.py
	$(MAKE) -C images/covers
	$(MAKE) -C images/portraits
	tox -e generate -- --format=yaml --filters=filters.py index.html.j2 index.yaml -o index.html

clean:
	$(MAKE) -C images/covers clean
	$(MAKE) -C images/portraits clean
	rm -f index.html
