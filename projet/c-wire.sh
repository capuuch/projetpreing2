#!/bin/bash
cheminfichier=$1
typestation=$2
typeconsommateur=$3

if [ $# -ne 3 ]; then
    echo "Erreur : Vous devez avoir 3 arguments"
fi

if [  ]; then
    if [ -f "c-wire" ]; then
    else 
        echo "Erreur : Vous n'avez pas écrit le bon chemin"
        exit 1
fi

if [ "$2" -ne "hvb" ] || [ "$2" -ne "hva" ] || [ "$2" -ne "lv" ]; then
    echo "Erreur : Vous devez écrire un des 3 types de stations en 2e argument"
    exit 2
fi

if [ "$2" -eq "hvb" ]; then
    if [ "$3" -ne "comp" ]; then 
    echo "Erreur : La combinaison écrite est fausse, une station hvb peut uniquement alimenter une companie"
    exit 3
fi



#awk commande à utiliser à la place de for()
#utiliser des long à la place des int dans le code en langage c