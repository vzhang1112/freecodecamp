#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=victoriazhang --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

MY_FILE="/Users/victoriazhang/Desktop/freecodecamp/worldcup/games.csv"

cat $MY_FILE | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do 
    # skip over the table header
    if [[ $YEAR != "year" ]]
    then
        # find the winner in teams
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        # if not found
        if [[ -z $WINNER_ID ]]
        then
            # insert into teams
            INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            # get newly inserted team's id
            WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        fi
        
        # now do the same for the opposing team
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        # if not found
        if [[ -z $OPPONENT_ID ]]
        then
            # insert into teams
            INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            # get the newly inserted team's id
            OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        fi

        # now insert all information into the games table
        INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
                            VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    fi
done