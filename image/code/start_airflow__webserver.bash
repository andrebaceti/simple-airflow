#!/bin/bash
echo "**************************"
echo "Starting Airflow Webserver"
echo "**************************"

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source "${SCRIPTPATH}/wait-for-postgres.bash"
source "${SCRIPTPATH}/wait-for-rabbitmq.bash"
source "${SCRIPTPATH}/create_airflow_variables.bash"
source "${SCRIPTPATH}/set_git.bash"

if [ -f "/airflow/dags/git_dags/requirements/requirements.txt" ]; then
    echo "Installing requirements.txt"
    pip install --requirement /airflow/dags/git_dags/requirements/requirements.txt --constraint /requirements/constraints.txt
fi

set -e
echo "# Checking if there is any migrations to apply at database"
airflow db init

set +e
echo "# Upgrading database"
airflow db upgrade

echo "# Starting webserver"
airflow webserver
