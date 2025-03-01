#!/bin/bash

IP=`hostname -I`
BASE="${IP%.*}"

for i in $(seq 0 0xff); do
    TARGET="$BASE.$i"

    if [ -n "$1" ]; then SN="$1"
    else SN=0.5; fi

    if ping -c 1 -W $SN $TARGET &> /dev/null; then
        echo "$TARGET Host is up!"
    fi
done
