#!/bin/bash

PSQL="psql -X --username=victoriazhang --dbname=salon --no-align --tuples-only -c"

# Delete tables each time script is rerun
$($PSQL "DROP TABLE customers, appointments, services")


# Customers table

$($PSQL "CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY NOT NULL,
    phone VARCHAR(30) UNIQUE NOT NULL,
    name VARCHAR(30)
)")


# Services table

$($PSQL "CREATE TABLE services(
    service_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(30)
)")

$($PSQL "INSERT INTO services(name) VALUES('cut and dry'), ('colour'), ('wash only')")

# Appointments table

$($PSQL "CREATE TABLE appointments(
    appointment_id SERIAL PRIMARY KEY NOT NULL,
    time VARCHAR(30),
    customer_id INT REFERENCES customers(customer_id),
    service_id INT REFERENCES services(service_id)
)")
