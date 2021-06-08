# Image for easilly create an Airflow with distribuited cellery by RabbitMQ

This project was created to vacillate creation of AirFlow deploy using a default configuration and database bootstrap.

## /image
Image for airflow deployment using RabbitMQ and Cellery. Images created:
- andrebaceti/simple-airflow:$version
- andrebaceti/test-db-simple-airflow:$version


## /test-aux
Auxiliary docker-compose to deploy locally airflow for tests and some initialization scripts.

`test-aux/docker-compose/docker-compose.yaml`

Using default test database in docker compose, users credentials are:
- **username:** admin
- **password:** admin
