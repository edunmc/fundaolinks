#!/bin/bash

# Gerar HTML da linha da tabela de determinada matéria
materia() { # pasta, nome
	echo "
				<tr>
					<td><a href=\"materias/$1/\">$2</a></td>
					<td>`cat "datas/$1"`</td>
				</tr>
				" >> index.html
}

# Salvar arquivo com a data do último backup
data() {
	echo "$(date +%F\ %T)" > "../datas/$1"
}



cd '/media/charmeleon/ufrj/2015-2/Sites/public'



# Baixar sites atualizados e atualizar data se o site estiver no ar
# (exit status 4 = network failure = site fora do ar)
cd 'materias'

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
if [ $? -eq 0 ]; then
	data 'logica'
	iconv -f ISO-8859-1 -t UTF-8 'logica/logica.html' -o 'logica/index.html' # consertar encoding
	find 'logica/index.html' -type f -exec sed -i 's/href="logica.html#/href="#/g' {} \; # consertar links que o wget modificou por causa do -k
	find 'logica/index.html' -type f -exec sed -i 's/href="http\:\/\/www\.cos\.ufrj\.br\/%7Emario\/logica\//href="/g' {} \; # tirar links absolutos
fi

# ***** SO *****
wget -t 1 -T 30 -N -nd -k -r -L -E -np -p -P so 'http://dcc.ufrj.br/~valeriab/mab366.php'
# request abaixo só da página principal, para saber se tá no ar. o anterior não vai ter o exit status de
# sucesso (0) nunca, pois um dos pdfs pegos recursivamente não existe e sempre dá 404 (e o wget vai retornar 8).
wget -q -O '/dev/null' 'http://dcc.ufrj.br/~valeriab/mab366.php'
if [ $? -eq 0 ]; then
	data 'so'
	
	# mudar encoding e meta tag de content-type pra utf-8, porque o firebase sempre manda header de utf-8
	iconv -f ISO-8859-1 -t UTF-8 'so/mab366.php.html' -o 'so/index.html'
	find 'so/index.html' -type f -exec sed -i 's/charset=iso-8859-1">/charset=utf-8">/g' {} \;
fi

# Gerar lista dos arquivos de BD da pasta "arquivos"
#tree -I 'index\.html' -H . -C 'bd/arquivos/' > 'bd/arquivos/index.html'


# Gerar index.html com as datas de backup atualizadas
cd ..
cat topo.html > index.html
#materia 'bd' 'Banco de Dados'
materia 'lp' 'Linguagens de Programação'
materia 'compiladores' 'Compiladores'
materia 'logica' 'Lógica'
materia 'so' 'Sistemas Operacionais'
cat baixo.html >> index.html

# Enviar
cd ..
firebase deploy
