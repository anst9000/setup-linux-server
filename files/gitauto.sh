#!/bin/sh


## ============================================================
## Variables
## ============================================================

FILES=NO_FILE

## ------------------------------------------------------------



## ============================================================
## Functions
## ============================================================

printInfo()
{
  printf "\n--> %s\n" "${1}"
}

askQuestion()
{
  printf "\n%s" "${1}"
}

## ------------------------------------------------------------



## ============================================================
## Script main
## ============================================================

printInfo "Running git pull"
git pull

printInfo "Asking a few questions"
askQuestion "What branch? "
read BRANCH

askQuestion "Add all files or specific [Aa]ll / [Ss]pecific: "
read ALLORSPECIFIC

case $ALLORSPECIFIC in
  [Aa] )
    FILES=.
    ;;

  [Ss] | * )
    askQuestion "Which file do you want to add? "
    read FILES
    ;;
esac

askQuestion "Enter commit message: "
read MESSAGE

git add $FILES
git commit -m "${MESSAGE}"

printInfo "Pushing data to GitHub"
git push -u origin $BRANCH

## ------------------------------------------------------------
