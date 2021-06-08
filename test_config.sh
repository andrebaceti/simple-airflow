#############
# Variables #
export DB_DIALECT="postgres"
export DB_USERNAME="pumpwood"
export DB_PASSWORD="pumpwood"
export DB_DATABASE="pumpwood"
export DB_HOST="0.0.0.0"
export DB_PORT="5432"

# RabbitMQ Queue for ETL worker
export RABBITMQ_USERNAME="pumpwood"
export RABBITMQ_PASSWORD="pumpwood"
export RABBITMQ_HOST="0.0.0.0"
export RABBITMQ_PORT="5672"


############
# Executor #
export AIRFLOW__CORE__EXECUTOR="CeleryExecutor"

###################
# Set directories #
export AIRFLOW__CORE__DAGS_FOLDER="../aux_dir/dags/"
export AIRFLOW__CORE__PLUGINS_FOLDER="../aux_dir/plugins/"
export AIRFLOW__LOGGING__BASE_LOG_FOLDER="../aux_dir/logs/"
export AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY="../aux_dir/scheduler_log/"

##################
# Host webserver #
# [webserver]
export AIRFLOW__WEBSERVER__BASE_URL="http://localhost:8080/"
export AIRFLOW__WEBSERVER__WEB_SERVER_HOST="0.0.0.0"
export AIRFLOW__WEBSERVER__WEB_SERVER_PORT="8080"
export AIRFLOW__WEBSERVER__SECRET_KEY_SECRET="o1vZ9ms0lEu2NaX7CXgfsw=="
##################
