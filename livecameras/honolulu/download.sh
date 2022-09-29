#!/bin/bash

saveDir='imgs'

if [ ! -d "$saveDir" ]; then
    mkdir $saveDir
fi

cat ./ips.txt | xargs -d'\n' -I @ sh -c 'wget -v -O imgs/@.jpg http://trafficcam2.honolulu.gov/images/@.jpg?timestamp=$(date -u +%s000)'

find . -size 0 -print0 | xargs -0 rm