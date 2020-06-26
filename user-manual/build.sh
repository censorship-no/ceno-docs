#!/bin/sh
# Usage: build.sh LANGUAGE
set -e
test -f "$1.toml"
conf="$1.toml"
test -L book.toml -o ! -e book.toml
ln -sf "$conf" book.toml
mdbook build
# [Remove Google surveillance](https://github.com/rust-lang/mdBook/issues/847).
# No longer needed with mdBook v0.40.0.
#outd=$(sed -En 's/^build-dir *= *"(.*)"/\1/p' "$conf")
#find "$outd" -name '*.html' | xargs sed -i '/<link href="[^"]*\bfonts\.googleapis\.com\b/d'
