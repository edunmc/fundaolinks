#!/bin/bash

data() {
	echo "$(date +%F\ %T)" > "../datas/$1"
}

# ***** LP *****
wget -t 1 -T 30 -N -nd -k -r -np -p -P lp 'http://dcc.ufrj.br/~fabiom/lp/'
wget -q -O '/dev/null' 'http://dcc.ufrj.br/~fabiom/lp/'
if [ $? -eq 0 ]; then data 'lp'; fi

# ***** Compiladores *****
wget -t 1 -T 30 -N -nd -k -r -np -p -P compiladores 'http://dcc.ufrj.br/~fabiom/comp/'
wget -q -O '/dev/null' 'http://dcc.ufrj.br/~fabiom/comp/'
if [ $? -eq 0 ]; then data 'compiladores'; fi

# ***** Logica *****
wget -t 1 -T 30 -N -nd -k -r -np -p -P logica 'http://www.cos.ufrj.br/~mario/logica/logica.html'
wget -q -O '/dev/null' 'http://www.cos.ufrj.br/~mario/logica/logica.html'
if [ $? -eq 0 ]; then data 'logica'; fi


# ***** Logica *****
wget -t 1 -T 30 -N -nd -k -r -np -p -P compgraf 'http://dontpad.com/CGaulas'
wget -q -O '/dev/null' 'http://dontpad.com/CGaulas'
if [ $? -eq 0 ]; then data 'logica'; fi
