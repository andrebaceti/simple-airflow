#!/bin/bash
echo "***********************"
echo "Starting Airflow Worker"
echo "***********************"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source "${SCRIPTPATH}/wait-for-postgres.bash"
source "${SCRIPTPATH}/wait-for-rabbitmq.bash"
source "${SCRIPTPATH}/create_airflow_variables.bash"
source "${SCRIPTPATH}/set_git.bash"

airflow celery worker
