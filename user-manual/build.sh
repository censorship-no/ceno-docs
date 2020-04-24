#!/bin/sh
set -e
mdbook build
# [Remove Google surveillance](https://github.com/rust-lang/mdBook/issues/847).
find book -name '*.html' | xargs sed -i '/<link href="[^"]*\bfonts\.googleapis\.com\b/d'
