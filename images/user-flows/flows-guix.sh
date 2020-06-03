#!/bin/sh

# Usage: flows-guix.sh --edit
#    or: flows-guix.sh [OUTPUT_PREFIX]

FLOWS_DIR="$(dirname "$(realpath "$0")")"

guix_env() {
guix time-machine --commit=b5c2d93d7a223155898dd0ed6932f6acf78ac454 \
     -- environment -CP --pure \
     --ad-hoc coreutils dash dia font-dejavu font-gnu-unifont font-gnu-freefont-ttf fontconfig grep sed \
     "$@"
}

if [ "$1" = "--edit" ]; then
    guix_env --share=$FLOWS_DIR --expose=/tmp/.X11-unix \
             -- env DISPLAY="$DISPLAY" dia "$FLOWS_DIR/flows.dia"
else
    guix_env --expose=$FLOWS_DIR \
             -- dash -c "fc-cache && dash $FLOWS_DIR/flows.sh $@"
fi
