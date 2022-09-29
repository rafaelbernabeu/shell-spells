#!/bin/bash

saveDir='imgs'

if [ ! -d "$saveDir" ]; then
    mkdir $saveDir
fi

if [ ! -f "ips.txt" ]; then
    curl "https://www.az511.gov/List/GetData/Cameras?query=%7B%22columns%22%3A%5B%7B%22data%22%3Anull%2C%22name%22%3A%22%22%7D%2C%7B%22name%22%3A%22sortId%22%2C%22s%22%3Atrue%7D%2C%7B%22name%22%3A%22cityName%22%2C%22s%22%3Atrue%7D%2C%7B%22name%22%3A%22roadway%22%2C%22s%22%3Atrue%7D%2C%7B%22name%22%3A%22roadNumber%22%7D%2C%7B%22data%22%3A5%2C%22name%22%3A%22%22%7D%2C%7B%22name%22%3A%22direction%22%7D%5D%2C%22order%22%3A%5B%7B%22column%22%3A2%2C%22dir%22%3A%22asc%22%7D%2C%7B%22column%22%3A4%2C%22dir%22%3A%22asc%22%7D%2C%7B%22column%22%3A6%2C%22dir%22%3A%22asc%22%7D%5D%2C%22start%22%3A0%2C%22length%22%3A10000%2C%22search%22%3A%7B%22value%22%3A%22%22%7D%7D&lang=en" > ips.txt
fi

cat ips.txt | jq '.data | .[].id' | xargs -d'\n' -I @ sh -c 'wget -v -O imgs/@.jpg https://www.az511.gov/map/Cctv/@'

find . -size 0 -print0 | xargs -0 rm