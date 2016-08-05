#!/usr/bin/env python
# -*- coding: utf-8 -*-

from subprocess import Popen

def chamar_wget(pasta, url):
    #rm = ['rm', '-rf', pasta]
    wget = ['wget', '-t', '1', '-T', '30', '-N', '-k', '-r', '-l', '1', '-E', '-np', '-p', '-P', pasta, url]
    #saida_rm = Popen(rm)
    saida_wget = Popen(wget)

    #print(saida_rm)
    print(saida_wget)

#usar para um teste onde download.sh seria um script com o comando wget, verificar
#a performance de chamar esse script parada cada linha com o python
def chamar_download_sh(pasta, url):
    download = Popen(['./download.sh',str(pasta),str(url)])
    print(download)

for line in open("materias"):
    line = line.split("|")

    pasta = line[2]#.decode('utf-8', 'ignore')
    url = line[3].strip('\n')#.decode('utf-8', 'ignore')

    chamar_wget(pasta, url)
