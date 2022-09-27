#!/bin/bash
export AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgres+psycopg2://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
export AIRFLOW__CELERY__BROKER_URL="amqp://${RABBITMQ_USERNAME}:${RABBITMQ_PASSWORD}@${RABBITMQ_HOST}:${RABBITMQ_PORT}/airflow"
export AIRFLOW__CELERY__RESULT_BACKEND="db+postgres://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

############################
# Install run dependencies #
pip install -r /requirements/requirements.txt
