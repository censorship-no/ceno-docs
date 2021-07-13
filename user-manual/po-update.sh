#!/bin/sh
# Usage: ./po-update.sh LANGUAGE
# Update PO files in `LANGUAGE` with latest PO templates from `en.pot`.

set -e

test "$1"
cd "$1"

for po in $(find . -name '*.po'); do
    tmp="$(mktemp)"
    msgmerge -q "$po" "../en.pot/${po}t" > "$tmp"
    mv "$tmp" "$po"
done
