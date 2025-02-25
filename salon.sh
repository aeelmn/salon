#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon ~~~~~\n"

SERVICE_MENU() {
#Add if condition that checks if there's an argument ($1) passed to the function. If there is, print the message with a new line in front of it.
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

echo "Which service would you like?" 
  echo -e "\n1) Cut\n2) Wash\n3) Massage"
  read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
    1) CUSTOMER_INFO ;;
    2) CUSTOMER_INFO ;;
    3) CUSTOMER_INFO ;;
    *) SERVICE_MENU "Please enter a valid option." ;;
  esac
}

CUSTOMER_INFO() {
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
# query name
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")
# get name if new customer


if [[ -z $CUSTOMER_NAME ]]
        then
          # get new customer name
          echo -e "\nWhat's your name?"
          read CUSTOMER_NAME


# insert new customer
INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
fi

echo -e "\nWhat time would you like to book?"
read SERVICE_TIME

# insert appointment
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
}

EXIT() {
SERVICE_NAME_SELECTED=$($PSQL "SELECT LOWER(name) FROM services WHERE service_id = $SERVICE_ID_SELECTED;")

  echo -e "\nI have put you down for a $(echo $SERVICE_NAME_SELECTED | sed -E 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."

}

# end message, appointment info


SERVICE_MENU

EXIT

