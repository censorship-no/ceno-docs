#!/bin/sh
# Usage: src-prepare.sh LANGUAGE
set -e

test "$1"
cd "$1"
DEST="../$1.src"

mkdir "$DEST"  # fail if existing
for po in $(find . -name '*.po'); do
    md="$(dirname "$po")/$(echo "$(basename "${po%%.po}" | sed -e 's/readme/README/' -e 's/summary/SUMMARY/').md")"
    mkdir -p "$(dirname "$DEST/$md")"
    po2md -q -w 100000 -p "$po" -s "$DEST/$md" "../en/$md"
done
# TODO: Copy images.
