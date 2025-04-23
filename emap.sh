#!/bin/bash

SN=0.5

while getopts "t:h" flag; do
    case "$flag" in
        h)
            echo "Kullanım: Komut [option] [argüman]"
            echo "   -h help"
            echo "   -t ping'lerin geri dönüşünü bekleme süresi"
            echo "   -i taranacak IP adresini manuel olarak belirleme"
            exit 0
            ;;
            
        t)
            if [[ "$OPTARG" =~ '^[0-9]$^[0-9]?\.[0-9]+$' ]]; then
                SN="$OPTARG"
            else
                echo "Geçersiz saniye değeri girildi." >&2
                exit 1
            fi
            ;;
            
        i) 
            if [[ "$OPTARG" =~ '^([0-9]{1,3}\.){3}[0-9]$' ]]; then
                IP="$OPTARG"
            else
                echo "Geçersiz IP adres formatı girildi." >&2
                exit 2
            fi
            ;;

        *)
            echo "Geçersiz kullanım." >&2
            exit 3
            ;;
    esac
done


IP="${IP:-$(hostname -I)}"
BASE="${IP%.*}"

for i in $(seq 0 0xff); do
    TARGET="$BASE.$i"
    
    if ping -c 1 -W $SN $TARGET > /dev/null; then
        echo "$TARGET Host is up!"
    fi

    sleep .08 # wait for SIGINT
done
