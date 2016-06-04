#!/usr/bin/env python
# -*- coding: utf-8 -*-

from subprocess import Popen

def chamar_wget(pasta, url):
    #rm = ['rm', '-rf', pasta]
    wget = ['wget', '-t', '1', '-T', '30', '-N', '-nd', '-k', '-r', '-E', '-np', '-p', '-P', pasta, url]
    #saida_rm = Popen(rm)
    saida_wget = Popen(wget)

    #print(saida_rm)
    print(saida_wget)

def chamar_download_sh(pasta, url):
    download = Popen(['./download.sh',str(pasta),str(url)])
    print(download)

for line in open("materias"):
    line = line.split("|")

    pasta = line[2]#.decode('utf-8', 'ignore')
    url = line[3].strip('\n')#.decode('utf-8', 'ignore')

    chamar_wget(pasta, url)
