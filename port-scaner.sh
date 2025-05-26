#!/bin/bash

for i in {1..65535}; do
  timeout 0.5 echo -n 2>/dev/null < /dev/tcp/$1/$i && echo "Port $i: open" #|| echo "closed"
done