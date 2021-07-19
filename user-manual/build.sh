#!/bin/sh
# Usage: ./build.sh LANGUAGE
# Render the Manual for the given language and place it under `LANGUAGE.book`.

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

# Fix output for RTL languages (needs <https://github.com/rust-lang/mdBook/pull/1489>).
if grep -qE '^_direction\s*=\s*"?rtl?"' "$conf"; then
    book="$(sed -nE 's/^build-dir\s*=\s"([^"]+)".*/\1/p' "$conf")"
    find "$book" -name '*.html' -exec sed -i 's/<body /<body dir="rtl" /' '{}' ';'
fi
