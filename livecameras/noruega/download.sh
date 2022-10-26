#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

saveDir=${SCRIPTPATH}/imgs
IPs=${SCRIPTPATH}/ips.txt

if [ ! -d $saveDir ]; then
    mkdir $saveDir
fi

if [ ! -f $IPs ]; then
    curl -H "Accept: application/json" https://webkamera.atlas.vegvesen.no/public/kameradata > $IPs
fi

cd $SCRIPTPATH

cat $IPs | jq '.[].id' | xargs -d'\n' -I @ sh -c 'wget -v -O imgs/@.jpg https://webkamera.atlas.vegvesen.no/public/kamera?id=@'

find . -size 0 -print0 | xargs -0 rm

cd -



