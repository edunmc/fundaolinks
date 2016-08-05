#!/bin/bash

while read -r line
do
    #echo $line
    pasta="$(cut -d'|' -f3 <<< $line)"
    #3echo $pasta
    url="$(cut -d"|" -f4 <<< $line)"
    #echo $url
    wget -t 1 -T 30 -N -k -r -l 1 -E -np -p -P $pasta $url

done < "$1"
