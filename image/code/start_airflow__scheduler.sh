#!/bin/bash
echo "**************************"
echo "Starting Airflow scheduler"
echo "**************************"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source "${SCRIPTPATH}/wait-for-postgres.sh"
source "${SCRIPTPATH}/wait-for-rabbitmq.sh"
source "${SCRIPTPATH}/create_airflow_variables.sh"

airflow scheduler
