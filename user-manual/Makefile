BOOKS := $(patsubst %.toml,%.book,$(subst book.toml,,$(wildcard *.toml)))

.PHONY: clean sync

all:	$(BOOKS)

clean:
	rm -rf *.src *.book book.toml

sync:
	./sync-to-web-repo.sh

# These do not really check for changes under the directory,
# so better run after cleaning up.

en.book:	en.toml en
	./build.sh en

%.book:	%.toml %.src
	./build.sh $*

%.src: %
	./src-prepare.sh $*
