#!/bin/bash

PSQL="psql --username=victoriazhang --dbname=number_guess --no-align --tuples-only -c"

RESTART=$($PSQL "DROP TABLE users, game")

ADD_USERS_TABLE=$($PSQL "CREATE TABLE users(
  username VARCHAR(30) NOT NULL UNIQUE,
  games_played INT NOT NULL,
  best_game INT NOT NULL)")

ADD_GAME_TABLE=$($PSQL "CREATE TABLE game(
  turn_id SERIAL PRIMARY KEY,
  guess INT NOT NULL)")