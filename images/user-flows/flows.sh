#!/bin/sh

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 DIAGRAM.dia"
    exit 1
fi

DIAGRAM="$1"

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

out_name="$(basename "${DIAGRAM%.*}")"
for icase in $(seq 0 $case_last); do
    echo "$case_tbl" | export_cmd $icase "${out_name}-$icase" | sh
done
