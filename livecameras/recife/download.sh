#!/bin/bash

saveDir='imgs'

if [ ! -d "$saveDir" ]; then
    mkdir $saveDir
fi

cat ~/cam_ips.txt | xargs -d'\n' -I % sh -c 'wget -O imgs/%.jpg http://transito.gtrans.com.br/cttupe/index.php/portal/getImg/%'