#!/bin/bash

echo "Digite o nome do usuario do github que deseja clonar todos repositorios"
read user

dir="meus-repositorios-git"


if [ -d "$dir" ]
then
	cd meus-repositorios-git
else
	mkdir meus-repositorios-git
	cd meus-repositorios-git
fi

repositorios=$(curl -s https://api.github.com/users/$user/repos | awk '/clone_url/{print $2}' | sed 's/^"//g' | sed 's/",$//')


for repositorio in $repositorios
do	
	vtemp=$(echo $repositorio | cut -d "/" -f 5 | sed 's/.git$//')
	
if [ -d "$vtemp" ]
then
	echo "O Repositorio $vtemp já foi clonado"
else
	git clone $repositorio
fi
done
