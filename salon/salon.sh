#!/bin/bash

PSQL="psql -X --username=victoriazhang --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ My Salon ~~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"


MAIN_MENU() {
ALL_SERVICES=$($PSQL "SELECT service_id, name FROM services")
echo "$ALL_SERVICES" | while IFS=' | ' read SERVICE_ID SERVICE_NAME
    do
    echo "$SERVICE_ID) $SERVICE_NAME"
    done

read SERVICE_ID_SELECTED
}

MAIN_MENU

# select service in database
VALIDATE_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

# if not found
if [[ -z $VALIDATE_SERVICE ]]
then
    # Send back to main menu
    MAIN_MENU "I could not find that service. What would you like today?"
else
    # If the service is found
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    
    # select customer from phone number
    VALIDATE_PHONE=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    # if not found
    if [[ -z $VALIDATE_PHONE ]]
    then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        ADD_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    else 
        # if found
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    fi
    echo -e "\nWhat time would you like your $VALIDATE_SERVICE, $CUSTOMER_NAME?"
    read SERVICE_TIME

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    CREATE_APPOINTMENT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
    echo -e "\nI have put you down for a $VALIDATE_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
fi
