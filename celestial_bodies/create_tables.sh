#!/bin/bash

PSQL="psql -X --username=victoriazhang --dbname=universe --no-align --tuples-only -c"

# every time you run this, delete all the old tables
echo "$($PSQL "DROP TABLE celestial_type, galaxy, star, planet, moon, celestials")"

###### ALL TYPES ######
$($PSQL "CREATE TABLE celestial_type(
  celestial_type_id SERIAL PRIMARY KEY,
  celestial_type_name VARCHAR(30) NOT NULL,
  name VARCHAR(30) NOT NULL UNIQUE)")
  # name is the is the actual name of the type, celestial_type_name is the body (galaxy/star/planet/moon)

###### GALAXIES ######
$($PSQL "CREATE TABLE galaxy(
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  celestial_type_id INT NOT NULL REFERENCES celestial_type(celestial_type_id),
  earth_viewable BOOLEAN NOT NULL,
  distance_from_earth NUMERIC(5,3))")

####### STARS ######
$($PSQL "CREATE TABLE star(
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  celestial_type_id INT NOT NULL REFERENCES celestial_type(celestial_type_id),
  galaxy_id INT REFERENCES galaxy(galaxy_id),
  known_planets INT NOT NULL,
  facts TEXT)")

###### PLANETS ######
$($PSQL "CREATE TABLE planet(
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  celestial_type_id INT NOT NULL REFERENCES celestial_type(celestial_type_id),
  star_id INT REFERENCES star(star_id),
  has_life BOOLEAN NOT NULL,
  facts TEXT)")

###### MOONS ######
$($PSQL "CREATE TABLE moon(
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  planet_id INT REFERENCES planet(planet_id),
  dist_from_planet INT NOT NULL,
  facts TEXT)")

###### CELESTIALS ######
$($PSQL "CREATE TABLE celestials(
  celestials_id SERIAL PRIMARY KEY,
  name VARCHAR(30) UNIQUE,
  galaxy_name VARCHAR(30) NOT NULL, 
  star_name VARCHAR(30),
  planet_name VARCHAR(30),
  moon_name VARCHAR(30))")
  # galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  # galaxy INT NOT NULL,
  # star_id INT REFERENCES star(star_id),
  # planet_id INT REFERENCES planet(planet_id),
  # moon_id INT REFERENCES moon(moon_id))")

