#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# check if there is a command line argument
if [[ ! -z $1 ]]
then 
  # if there is, then assign it to ARG_ELEMENT
  ARG_ELEMENT=$1

  # if an atomic number was provided
  if [[ "$ARG_ELEMENT" =~ ^[0-9]+$ ]]
  then
    # then query database based on atomic number
    ARG_ATOMIC_NUM=$($PSQL "SELECT * FROM properties INNER JOIN elements ON properties.atomic_number=elements.atomic_number INNER JOIN types ON types.type_id=properties.type_id WHERE properties.atomic_number = '$ARG_ELEMENT'")
    if [[ ! -z $ARG_ATOMIC_NUM ]] 
    then
      echo "$ARG_ATOMIC_NUM" | while IFS="|" read PROP_ATOMIC_NUMBER ATOMIC_MASS MELT_PT BOIL_PT TYPE_ID ELE_ATOMIC_NUMBER SYMBOL NAME TYPE_ID TYPE
      do
        echo -e "The element with atomic number $PROP_ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_PT celsius and a boiling point of $BOIL_PT celsius."
      done
    else
      echo I could not find that element in the database.
    fi

  # if an atomic symbol was provided
  elif [[ ${#ARG_ELEMENT} -le 2 ]]
  then
    ARG_ATOMIC_SYMBOL=$($PSQL "SELECT * FROM properties INNER JOIN elements ON properties.atomic_number=elements.atomic_number INNER JOIN types ON types.type_id=properties.type_id WHERE symbol = '$ARG_ELEMENT'")
    if [[ ! -z $ARG_ATOMIC_SYMBOL ]]
    then
      echo "$ARG_ATOMIC_SYMBOL" | while IFS="|" read PROP_ATOMIC_NUMBER ATOMIC_MASS MELT_PT BOIL_PT TYPE_ID ELE_ATOMIC_NUMBER SYMBOL NAME TYPE_ID TYPE
      do
        echo -e "The element with atomic number $PROP_ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_PT celsius and a boiling point of $BOIL_PT celsius."
      done
    else
      echo I could not find that element in the database.
    fi

  # if a name was provided
  elif [[ ${#ARG_ELEMENT} -ge 2 ]]
  then
    ARG_ATOMIC_NAME=$($PSQL "SELECT * FROM properties INNER JOIN elements ON properties.atomic_number=elements.atomic_number INNER JOIN types ON types.type_id=properties.type_id WHERE name= '$ARG_ELEMENT'")
    if [[ ! -z $ARG_ATOMIC_NAME ]] 
    then
      echo "$ARG_ATOMIC_NAME" | while IFS="|" read PROP_ATOMIC_NUMBER ATOMIC_MASS MELT_PT BOIL_PT TYPE_ID ELE_ATOMIC_NUMBER SYMBOL NAME TYPE_ID TYPE
      do
        echo -e "The element with atomic number $PROP_ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_PT celsius and a boiling point of $BOIL_PT celsius."
      done
    else
      echo I could not find that element in the database.
    fi
  fi
else
  # if there isn't, then print a prompt
  echo Please provide an element as an argument.
fi
