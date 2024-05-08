#!/bin/bash

#PSQL
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

EXTRACT_USING_ATOMIC_NUMBER() {

  CHECK_ATOMIC_NUMBER=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_ID) WHERE atomic_number = $1;")

  if [[ -z $CHECK_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_NAME <<< "$CHECK_ATOMIC_NUMBER"
   
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi

}

EXTRACT_USING_SYMBOl() {

  CHECK_SYMBOL=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_ID) WHERE symbol ='$1';")

  if [[ -z $CHECK_SYMBOL ]]
  then
    echo "I could not find that element in the database."
  else
    IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_NAME <<< "$CHECK_SYMBOL"
   
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi

}

EXTRACT_USING_NAME() {

  CHECK_NAME=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_ID) WHERE name = '$1';")

  if [[ -z $CHECK_NAME ]]
  then
    echo "I could not find that element in the database."
  else
    IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_NAME <<< "$CHECK_NAME"
   
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi

}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^-?[0-9]+$ ]]
  then
    EXTRACT_USING_ATOMIC_NUMBER "$1"
  elif [[ $1 =~ ^.$ || $1 =~ ^..$ ]]
  then
    EXTRACT_USING_SYMBOl "$1"
  else
    EXTRACT_USING_NAME "$1"
  fi
fi
