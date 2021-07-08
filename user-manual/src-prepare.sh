#!/bin/sh
# Usage: ./src-prepare.sh LANGUAGE
# Prepare the sources for a Manual translation and place them under `LANGUAGE.src`.

set -e

test "$1"
cd "$1"
DEST="../$1.src"

mkdir "$DEST"  # fail if existing

# Generate Markdown files from PO translations.
for po in $(find . -name '*.po'); do
    md="$(dirname "$po")/$(echo "$(basename "${po%%.po}" | sed -e 's/readme/README/' -e 's/summary/SUMMARY/').md")"
    mkdir -p "$(dirname "$DEST/$md")"
    po2md -q -w 100000 -p "$po" -s "$DEST/$md" "../en/$md"
done

# Copy translated images.
for img in $(find . -name '*.png' -o -name '*.svg'); do
    imgd="$(dirname "$DEST/$img")"
    mkdir -p "$imgd"
    cp "$img" "$imgd"
done

# Copy non-translated images.
cd ../en
for img in $(find . -name '*.png' -o -name '*.svg'); do
    imgd="$(dirname "$DEST/$img")"
    if test -f "$imgd/$(basename "$img")"; then continue; fi
    mkdir -p "$imgd"
    cp "$img" "$imgd"
done
