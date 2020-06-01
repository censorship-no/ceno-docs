#!/bin/sh

# This script takes the Dia `$DIAGRAM_FILE` sitting next to it and,
# for each layer having a name not in parentheses,
# it creates an output SVG file named `OUT_NAME-N.svg` in the current directory
# (with N=0,1,2...).
#
# When generating the output file for a given layer,
# the rest of layers are hidden with the exception of
# layers below it having a name in parentheses.
# For instance, when generating the file for the layer "Baz" below:
#
#     Baz
#     Bar
#     (X2)
#     Foo
#     (X1)
#
# Only layers "Baz", "(X2)" and "(X1)" are shown.
# For the layer "Foo", only "Foo" and "(X1)" are shown.

set -e

DIAGRAM_FILE="flows.dia"

if [ $# -gt 1 ]; then
    echo "Usage: $0 [OUT_NAME]"
    exit 1
fi

DIAGRAM="$(dirname "$(realpath "$0")")/$DIAGRAM_FILE"
OUT_NAME="${1:-$(basename "${DIAGRAM%.*}")}"

gen_case_table() {  # DIAGRAM
    local diagram="$1"
    sed -En 's/.*<dia:layer\b.*\bname="([^"]+)".*/\1/p' "$diagram" \
    | {
        icase=0
        while read layer; do
            echo $icase "${layer}"
            ilayer=$((ilayer+1))
            if echo "$layer" | grep -vq '^('; then
                cases="${cases}${layer}\n"
                icase=$((icase+1))
            fi
        done
    }
}

layer_visible_subst() {  # LAYER_NAME LAYER_VISIBLE
    local n="$(echo "$1" | sed 's/\([()]\)/\\\1/g')"
    echo 's/(.*<dia:layer\\b.*\\bname="'"$n"'".*\\bvisible=")[^"]+(".*)/\\1'"$2"'\\2/'
}

sed_substs() {  # CASE_N < CASE_TABLE
    local case_n=$1
    while read case_line; do
        case_num="${case_line%% *}"
        layer_name="${case_line#* }"
        if [ $case_num -gt $case_n ]; then
            layer_visible_subst "$layer_name" false
        elif [ $case_num -eq $case_n ]; then
            layer_visible_subst "$layer_name" true
        elif echo "$layer_name" | grep -q ')$'; then
            layer_visible_subst "$layer_name" true
        else
            layer_visible_subst "$layer_name" false
        fi
    done
}

export_cmd() {  # CASE_N OUT_NAME < CASE_TABLE
    local case_n=$1 out_name="$2"
    echo 'tmp=$(mktemp)'
    echo 'sed -E \\'
    sed_substs $case_n | sed -E "s/(.*)/ -e '\1' \\\\/"
    echo " \"$DIAGRAM\" > \"\$tmp\""
    echo "dia -e \"$out_name.svg\" -t cairo-svg \"\$tmp\""
    echo "rm -f \"\$tmp\""
}

case_tbl="$(gen_case_table "$DIAGRAM")"
case_last=$(echo "$case_tbl" | tail -1 | cut -f1 -d' ')

for icase in $(seq 0 $case_last); do
    echo "$case_tbl" | export_cmd $icase "${OUT_NAME}-$icase" | dash
done
