#!/bin/bash

PSQL="psql -X --username=victoriazhang --dbname=universe --no-align --tuples-only -c"

# every time you run this, delete all the old data but keep the tables
echo "$($PSQL "TRUNCATE celestial_type, galaxy, star, planet, moon, celestials")"

cat /Users/victoriazhang/Desktop/celestial_bodies/celestials.csv | while IFS="," read CELESTIAL TYPE_NAME GALAXY_NAME STAR_NAME PLANET_NAME MOON_NAME EARTH_VIEWABLE DIST_FROM_EARTH KNOWN_PLANETS FACTS HAS_LIFE DIST_FROM_PLANET
do

    # Retrieve celestial_type_id from celestial_type
    TYPE_ID=$($PSQL "SELECT celestial_type_id FROM celestial_type WHERE name='$TYPE_NAME'")
    # if TYPE_NAME not in celestial_type
    if [[ -z $TYPE_ID ]]
        then
        # Add TYPE_NAME and celestial_type_id into celestial_type
        $($PSQL "INSERT INTO celestial_type(name, celestial_type_name) VALUES ('$TYPE_NAME', '$CELESTIAL')")
        # Save celestial_type_id
        TYPE_ID=$($PSQL "SELECT celestial_type_id FROM celestial_type WHERE name='$TYPE_NAME'")
    fi



    # if CELESTIAL is GALAXY
    if [[ $CELESTIAL == "GALAXY" ]]
        then
        # Populate all the galaxy information
        $($PSQL "INSERT INTO galaxy(name, celestial_type_id, earth_viewable, distance_from_earth) VALUES ('$GALAXY_NAME', $TYPE_ID, $EARTH_VIEWABLE, $DIST_FROM_EARTH)")
        # Save galaxy_id
        # GALAXY_ID=$($PSQL "SELECT galaxy_id FROM galaxy WHERE name='$GALAXY_NAME'")
        # Add all IDs into celestials table
        $($PSQL "INSERT INTO celestials(galaxy_name) VALUES('$GALAXY_NAME')")
    fi
    
    # Do the same for all other celestials

    # if CELESTIAL is STAR
    if [[ $CELESTIAL == "STAR" ]]
        then
        # Save galaxy_id
        # GALAXY_ID=$($PSQL "SELECT galaxy_id FROM galaxy WHERE name='$GALAXY_NAME'")
        # Populate all the star information
        $($PSQL "INSERT INTO star(name, celestial_type_id, known_planets, facts) VALUES ('$STAR_NAME', $TYPE_ID, $KNOWN_PLANETS, '$FACTS')")
        # Save star_id
        # STAR_ID=$($PSQL "SELECT star_id FROM star WHERE name='$STAR_NAME'")
        # Add all IDs into celestials table
        $($PSQL "INSERT INTO celestials(galaxy_name, star_name) VALUES('$GALAXY_NAME', '$STAR_NAME')")
    fi

    # if CELESTIAL is PLANET
    if [[ $CELESTIAL == "PLANET" ]]
        then
        # Save star_id
        # STAR_ID=$($PSQL "SELECT star_id FROM star WHERE name='$STAR_NAME'")
        # Populate all the star information
        $($PSQL "INSERT INTO planet(name, celestial_type_id, has_life, facts) VALUES ('$PLANET_NAME', $TYPE_ID, $HAS_LIFE, '$FACTS')")
        # Add all IDs into celestials table
        $($PSQL "INSERT INTO celestials(galaxy_name, star_name, planet_name) VALUES('$GALAXY_NAME', '$STAR_NAME', '$PLANET_NAME')")
    fi

    # if CELESTIAL is MOON
    if [[ $CELESTIAL == "MOON" ]]
        then
        # Save planet_id
        # PLANET_ID=$($PSQL "SELECT planet_id FROM planet WHERE name='$PLANET_NAME'")
        # Populate all the moon information
        $($PSQL "INSERT INTO moon(name, dist_from_planet, facts) VALUES ('$MOON_NAME', $DIST_FROM_PLANET, '$FACTS')")
        # Add all IDs into celestials table
        $($PSQL "INSERT INTO celestials(galaxy_name, star_name, planet_name, moon_name) VALUES('$GALAXY_NAME', '$STAR_NAME', '$PLANET_NAME', '$MOON_NAME')")
    fi
done