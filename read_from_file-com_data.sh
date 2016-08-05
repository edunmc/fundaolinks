#!/bin/bash
# Salvar arquivo com a data do último backup
data() {
	echo "$(date +%F\ %T)" > "../datas/$1"
}

while read -r line
do
    #echo $line
    pasta="$(cut -d'|' -f3 <<< $line)"
    #3echo $pasta
    url="$(cut -d"|" -f4 <<< $line)"
    #echo $url
    wget -t 1 -T 30 -N -nd -k -r -E -np -p -P $pasta '$url'
    wget -q -O '/dev/null' $url
    if [ $? -eq 0 ]; then data $pasta; fi
done < "$1"
