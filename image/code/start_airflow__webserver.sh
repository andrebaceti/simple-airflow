#!/bin/bash
echo "**************************"
echo "Starting Airflow Webserver"
echo "**************************"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source "${SCRIPTPATH}/wait-for-postgres.sh"
source "${SCRIPTPATH}/wait-for-rabbitmq.sh"
source "${SCRIPTPATH}/create_airflow_variables.sh"

echo "# Checking if there is any migrations to apply at database"
airflow db init

echo "# Starting webserver"
airflow webserver
