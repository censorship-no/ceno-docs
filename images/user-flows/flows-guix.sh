#!/bin/sh

FLOWS_SCRIPT="$(dirname "$(realpath "$0")")/flows.sh"

guix time-machine --commit=b5c2d93d7a223155898dd0ed6932f6acf78ac454 \
     -- environment -CP --pure --expose=$(realpath $(dirname $FLOWS_SCRIPT)) \
     --ad-hoc coreutils dash dia font-dejavu font-gnu-unifont font-gnu-freefont-ttf fontconfig grep sed \
     -- dash -c "fc-cache && dash $FLOWS_SCRIPT $@"
