#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

saveDir=${SCRIPTPATH}/imgs
IPs=${SCRIPTPATH}/ips.txt

if [ ! -d $saveDir ]; then
    mkdir $saveDir
fi

cd $SCRIPTPATH

cat $IPs | xargs -d'\n' -I @ sh -c 'wget -v -O imgs/@.jpg http://trafficcam2.honolulu.gov/images/@.jpg?timestamp=$(date -u +%s000)'

find . -size 0 -print0 | xargs -0 rm

cd -