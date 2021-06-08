#!/bin/bash
echo "***********************"
echo "Starting Airflow Worker"
echo "***********************"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source "${SCRIPTPATH}/wait-for-postgres.sh"
source "${SCRIPTPATH}/wait-for-rabbitmq.sh"
source "${SCRIPTPATH}/create_airflow_variables.sh"

airflow celery worker
