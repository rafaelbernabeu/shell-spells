#!/bin/bash

saveDir='imgs'

if [ ! -d "$saveDir" ]; then
    mkdir $saveDir
fi

if [ ! -f "ips.txt" ]; then
    curl -H "Accept: application/json" https://webkamera.atlas.vegvesen.no/public/kameradata > ips.txt
fi

cat ips.txt | jq '.[].id' | xargs -d'\n' -I @ sh -c 'wget -v -O imgs/@.jpg https://webkamera.atlas.vegvesen.no/public/kamera?id=@'

find . -size 0 -print0 | xargs -0 rm



