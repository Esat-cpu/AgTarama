#!/bin/bash

IP=`hostname -I`
BASE="${IP%.*}"

for i in $(seq 0 0xff); do
    TARGET="$BASE.$i"

    if [[ "$1" =~ ^[0-9]$|^[0-9]?\.[0-9]+$ ]]; then SN="$1"
    else SN=0.5; fi

    if ping -c 1 -W $SN $TARGET &> /dev/null; then
        echo "$TARGET Host is up!"
    fi

    sleep .08 # wait for SIGINT
done
