#!/bin/bash
set -e

until curl -sSf ${RABBITMQ_HOST}:15672 > /dev/null; do
  >&2 echo "${RABBITMQ_HOST}:15672 RabbitMQ is unavailable"
  sleep 1
done
echo "${RABBITMQ_HOST}:15672 RabbitMQ is ok!!"

echo "Creating virtual host 'airflow'"
curl -u $RABBITMQ_USERNAME:$RABBITMQ_PASSWORD -X PUT http://${RABBITMQ_HOST}:15672/api/vhosts/airflow
