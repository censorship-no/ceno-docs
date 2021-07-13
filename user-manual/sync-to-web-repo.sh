#!/bin/sh
# Usage: ./sync-to-web-repo.sh
# Use rsync to update manuals in the CENO web repo `../../ceno.github.io`.

set -e

WEB_REPO="${WEB_REPO:-../../ceno.github.io}"

for book in *.book; do
    lang="${book%%.book}"
    rsync -rl --del "$book/" "$WEB_REPO/user-manual/$lang/"
done

echo "Please check, commit and push changes to web repo: $WEB_REPO"
