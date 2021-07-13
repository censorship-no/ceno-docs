#!/bin/sh
# Usage: ./pot-extract.sh
# Extract PO templates from English sources and place them under `en.pot`.

set -e

cd en
POT_DIR=../en.pot

for md in $(find . -name '*.md'); do
    pot="$POT_DIR/${md%%.md}.pot"
    mkdir -p "$(dirname "$pot")"
    md2po -d 'Content-Type: text/plain; charset=utf-8' "$md" | msgattrib --clear-fuzzy --empty - > "$pot"
done
