#!/bin/bash
export AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgresql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
export AIRFLOW__CELERY__BROKER_URL="amqp://${RABBITMQ_USERNAME}:${RABBITMQ_PASSWORD}@${RABBITMQ_HOST}:${RABBITMQ_PORT}/airflow"
export AIRFLOW__CELERY__RESULT_BACKEND="db+postgresql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

############################
# Install run dependencies #
pip install -r /requirements/requirements.txt

# # Check if Kong API is set, if so set base Airflow to match route /airflow
if [ -v KONG_API_URL ];then
    echo "# KONG_API_URL is set, registering end-point"
    export AIRFLOW__WEBSERVER__BASE_URL="http://0.0.0.0:8080/airflow"
    python -u /airflow/add_kong_route.py
else
    echo "# KONG_API_URL is not set"
fi
