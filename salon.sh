#! /bin/bash
PSQL="psql -x --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  echo "How may I help you?" 
  echo -e "\n1) cut\n2) color\n3) perm\n4) exit"
  read SERVICE_ID_SELECTED
  
  case $SERVICE_ID_SELECTED in
  1) APPOINTMENT ;;
  2) APPOINTMENT ;;
  3) APPOINTMENT ;;
  4) EXIT ;;
  *) MAIN_MENU "Please enter a valid option." ;;
  esac
}
APPOINTMENT(){
  echo -e "\nEnter your phone number."
  read CUSTOMER_PHONE

   # Buscar cliente en la base de datos
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_NAME ]]; then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    # Utilizar consulta preparada para evitar inyección SQL
    INSERT_DATES=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
  # obtener el id del servicio
 
   # Pedir hora de la cita
  echo -e "\nWhat time would you like to schedule?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  CUSTOMER_ID_VALUE=$(echo $CUSTOMER_ID | sed 's/[^0-9]*//g')


  $PSQL "INSERT INTO appointments (time, customer_id,service_id) VALUES ('$SERVICE_TIME',$CUSTOMER_ID_VALUE,$SERVICE_ID_SELECTED)"
SERVICE_NAME=$(echo $($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED") | sed 's/[^a-zA-Z]*//g' | sed 's/name//')
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}




MAIN_MENU


















  
  