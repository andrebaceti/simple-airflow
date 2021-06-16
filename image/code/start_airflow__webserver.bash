#!/bin/bash
echo "**************************"
echo "Starting Airflow Webserver"
echo "**************************"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source "${SCRIPTPATH}/wait-for-postgres.bash"
source "${SCRIPTPATH}/wait-for-rabbitmq.bash"
source "${SCRIPTPATH}/create_airflow_variables.bash"
source "${SCRIPTPATH}/set_git.bash"

echo "# Checking if there is any migrations to apply at database"
airflow db init

echo "# Starting webserver"
airflow webserver
