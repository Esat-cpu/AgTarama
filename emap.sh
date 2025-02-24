#!/bin/bash

IP=`hostname -I`
BASE="${IP%.*}"

for i in $(seq 0 0xff); do
    TARGET="$BASE.$i"

    if ping -c 1 -W 0.1 $TARGET &> /dev/null; then
        echo "$TARGET Host is up!"
    fi
done

