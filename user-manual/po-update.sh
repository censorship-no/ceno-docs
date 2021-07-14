#!/bin/sh
# Usage: ./po-update.sh
# Update PO files with latest PO templates from `en.pot`.

set -e

for po in $(find . -name '*.po'); do
    pot="en.pot/$(echo "$po" | sed -E 's#^\./[^/]+/##')t"
    msgmerge -q --previous -U "$po" "$pot"
done
