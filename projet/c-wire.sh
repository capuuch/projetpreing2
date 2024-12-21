#!/bin/bash
cheminfichier=$1
typestation=$2
typeconsommateur=$3

help() {
  echo "Usage : $0 <chemin_csv> <type_station> <type_consommateur>"
  echo "Options :"
  echo "  - <chemin_csv> : il faut saisir le chemin du fichier à traiter"
  echo "  - <type_station> : il faut saisir le type de station (hvb, hva, lv)"
  echo "  - <type_consommateur> : il faut saisir le type de consommateur (comp, indiv, all)"
  echo "Attention : vous ne pouvez pas saisir ces combinaisons (hvb-all, hva-all, hvb-individual, hva-individual)"
  echo "  Pour affiche cette aide taper -h"
}

if [ "$1" == "-h" ]; then
echo "Nous allons vous aider"
  help
  exit 0
fi

if [ $# -ne 3 ]; then
    echo "Erreur : Vous devez avoir 3 arguments"
    help
    exit 1
fi

if [ ! -f "$cheminfichier" ]; then
    echo "Erreur : le chemin du ficher est incorrect"
    help
    exit 2
fi

if [[ "$typestation" -ne "hvb" && "$typestation" -ne "hva" && "$typestation" -ne "lv" ]]; then
    echo "Erreur : Vous devez écrire un des 3 types de stations en 2e argument"
    help
    exit 3
fi

if [[ "$typeconsommateur" != "comp" && "$typeconsommateur" != "ind" && "$typeconsommateur" != "all" ]]; then 
    echo "Erreur : Vous devez écrire un des 3 types de consommateurs en 3e argument"
    help 
    exit 4
fi

if [[ "$typestation" == "hvb" && "$typeconsommateur" != "comp" ]]; then
  echo "Erreur : Ces combinaisons ne fonctionnent pas"
  afficher_aide
  exit 5
fi

if [[ "$typestation" == "hva" && "$typeconsommateur" != "comp" ]]; then
  echo "Erreur : Ces combinaisons ne fonctionnent pas"
  afficher_aide
  exit 6
fi

if [[ ! -f "codeC/cwire" ]]; then
  echo "Compilation du programme C..."
  make -C codeC
  if [[ $? -ne 0 ]]; then
    echo "Erreur : La compilation du programme C a échoué."
    exit 1
  fi
fi

# Préparer les fichiers 
tmp="./tmp"

if [[ -d "$tmp" ]]; then
    rm -rf "$tmp"
fi
mkdir -p "$tmp"

# Mesurer le temps de traitement
temps_debut=$(date +%s.%N)

# Appeler le programme C pour traiter les données
echo "Lancement du traitement avec le programme C..."
./codeC/cwire "$cheminfichier" "$typestation" "$typeconsommateur" > "$tmp/output.csv"
if [[ $? -ne 0 ]]; then
    echo "Erreur : Le traitement des données a échoué."
    temps_fin=$(date +%s.%N)
    duree=$(echo "$temps_fin - $temps_debut" | bc)
    echo "Durée du traitement : ${duree}s"
    exit 7
fi

# Fin du traitement
temps_fin=$(date +%s.%N)
duree=$(echo "$temps_fin - $temps_debut" | bc)
echo "Durée du traitement : ${duree}s"

echo "Le traitement est terminé. Les résultats se trouvent dans le dossier '$tmp'."



#awk commande à utiliser à la place de for()
#utiliser des long à la place des int dans le code en langage c
