#!/bin/bash

saveDir='imgs'

if [ ! -d "$saveDir" ]; then
    mkdir $saveDir
fi

cat ~/cam_ips.txt | xargs -d'\n' -I @ sh -c 'wget -O imgs/@_$(date +%Y%m%d_%H%M%S).jpg http://transito.gtrans.com.br/cttupe/index.php/portal/getImg/@'

find . -size 0 -print0 | xargs -0 rm