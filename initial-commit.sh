#!/bin/bash

if [[ ! $1 ]]; then
	echo 'É necessário passar o nome do projeto como parâmetro.'
	exit 1
fi

PROJPATH="$HOME/devel/$1"
if [[ -e "$PROJPATH" ]]; then
	echo 'Projeto já existe.'
	exit 1
fi

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

mkdir "$PROJPATH"
echo "Diretório $PROJPATH criado."

cp "$SCRIPTPATH"/gitignore "$PROJPATH"/.gitignore
cp "$SCRIPTPATH"/composer.json "$PROJPATH"/composer.json
cp "$SCRIPTPATH"/index.php "$PROJPATH"/index.php
cp "$SCRIPTPATH"/wp-config.php "$PROJPATH"/wp-config.php-sample

sed -i "s/<project-name>/$1/g" "$PROJPATH"/wp-config.php-sample

pushd "$PROJPATH"

mkdir wp-content

ln -s ../wp/wp-content/themes wp-content/themes

git init
echo "Git inicializado."

git add *

git commit -m "initial commit"

popd

exit 0
