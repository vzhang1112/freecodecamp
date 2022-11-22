#!/bin/bash

RAND_NUM=$(( $RANDOM % 1000 + 1 ))

PSQL="psql --username=victoriazhang --dbname=number_guessing --no-align --tuples-only -c"

PROCESS_GUESS() {
  # if the guess is a not a number: 
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    NOT_NUMBER
  else
    # as long as the guess is a number, first add to game record
    ADD_TO_GAME=$($PSQL "INSERT INTO game(guess) VALUES($1)")

    # if the guess is not equal to the random number
    if [[ $1 -ne $2 ]]
    then
      # if the guess is greater than the random number
      if [[ $1 -gt $2 ]]
      then
        GREATER_THAN $2
      fi

      # if the guess is less than the random number
      if [[ $1 -lt $2 ]]
      then
        LESS_THAN $2
      fi

    # if the guess is the same as the random number
    else
      EXIT
    fi
  fi
}

NOT_NUMBER() {
  echo That is not an integer, guess again:
  read NEW_GUESS
  PROCESS_GUESS $NEW_GUESS $1
}

GREATER_THAN() {
  echo It\'s lower than that, guess again:
  read NEW_GUESS
  PROCESS_GUESS $NEW_GUESS $1
}

LESS_THAN() {
  echo It\'s higher than that, guess again:
  read NEW_GUESS
  PROCESS_GUESS $NEW_GUESS $1
}

EXIT() {
  GUESSES_NEEDED=$($PSQL "SELECT COUNT(*) FROM game")
  NEW_GAMES_PLAYED=1+$GAMES_PLAYED
  # need to update best game score if this time required fewer guesses
  if [[ $BEST_GAME -eq 0 || $BEST_GAME -gt $GUESSES_NEEDED ]]
  then
    # then update the best game record
    UDPATE_BEST_GAME=$($PSQL "UPDATE users SET best_game=$GUESSES_NEEDED WHERE username='$USERNAME'")
  fi
  ADD_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played=$NEW_GAMES_PLAYED WHERE username='$USERNAME'")
  echo You guessed it in $GUESSES_NEEDED tries. The secret number was $RAND_NUM. Nice job!
}


# grab the username from user input
echo Enter your username:
read USERNAME

if [[ -z $USERNAME ]]
then
  echo A username is required.
else
  # check if user has been added or not 
  CHECK_USERNAME=$($PSQL "SELECT * FROM users WHERE username = '$USERNAME'")
  # if user has not been added 
  if [[ -z $CHECK_USERNAME ]]
  then
    # add username into database
    ADD_USERNAME=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, 0)")
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
    BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
    # output welcome message 
    echo Welcome, $USERNAME! It looks like this is your first time here.
  else 
    # if user has already been added
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
    BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
    # output welcome message
    echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
  fi

  # clear all game sessions 
  CLEAR_OLD_GAME=$($PSQL "TRUNCATE game")
  # collect first guess
  echo Guess the secret number between 1 and 1000:
  read CURR_GUESS

  # send to the function to determine the guess
  PROCESS_GUESS $CURR_GUESS $RAND_NUM
fi