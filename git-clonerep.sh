#!/bin/bash

# /home/user
cd ~

DIRECTORY="Projetos"

# Verifica se o diretório não exite e cria-o
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
    echo "Diretório criado"
fi

# Entrar no diretório
cd Projetos

# id do usuario / o mesmo do git
USUARIO=$(git config user.name)

# pega json que contem todos os repositorios e extrai as URLs (API do GitHub)
LIST_URL_CLONES=`curl --silent https://api.github.com/users/$USUARIO/repos -q | 
    grep "\"clone_url\"" |
    awk -F': "' '{print $2}' |
    sed -e 's/",//g'`

#para cada url faz um 'git clone'
for URL in $LIST_URL_CLONES; do
    echo "==>> clonando: " ${URL}
    git clone ${URL}
done