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

## Image environment variables:
##### Database connection
- **DB_DIALECT="postgres":** SQLAlchemy dialect.
- **DB_USERNAME="pumpwood":**: Database username.
- **DB_PASSWORD="pumpwood":** Database password.
- **DB_DATABASE="pumpwood":** Database airflow database.
- **DB_HOST="0.0.0.0":** Airflow db host address.
- **DB_PORT="5432":** Airflow db host port.

##### RabbitMQ Queue for ETL worker
- **RABBITMQ_USERNAME="pumpwood":** RabbitMQ username for celery executor.
- **RABBITMQ_PASSWORD="pumpwood":** RabbitMQ password for celery executor.
- **RABBITMQ_HOST="0.0.0.0":** RabbitMQ host for celery executor.
- **RABBITMQ_PORT="5672":** RabbitMQ port for celery executor.

##### Executor
- **AIRFLOW__CORE__EXECUTOR="CeleryExecutor":** Set executor to
    CeleryExecutor. I think in Kubernet it will be possible to set it for
    CeleryKubernetesExecutor.

##### Host webserver [webserver]
- **AIRFLOW__WEBSERVER__BASE_URL="http://localhost:8080/":**
- **AIRFLOW__WEBSERVER__WEB_SERVER_HOST="0.0.0.0":** Host of the webserver.
- **AIRFLOW__WEBSERVER__WEB_SERVER_PORT="8080":** Port to serve the webserver.
- **AIRFLOW__WEBSERVER__SECRET_KEY_SECRET="o1vZ9ms0lEu2NaX7CXgfsw==":** Secret key
    for flask login on the webserver. HAVE TO CHANGE THIS ON PRODUCTION!

##### Git integration
- **GIT_SERVER:** Sets the git sever to set in know_hosts for ssh keys. This
    skips the user interaction at first clone of the repository.
- **GIT_REPOSITORY:**: Sets the git repository used to integrate the dags.
- **GIT_BRANCH="master"**: Set which branch should be used to integrate the
    dags. This can be used to differ production, staging and development
    environments.

## Image mounted secrets:
The git user authentication is done by ssh keys associated with the repository.
In the test docker-compose this configuration is done by airflow--ssh volumes
which contains files:
- **id_rsa:** SSH key.
- **id_rsa.pub:** Public SSH keys.

##### How create SSH keys for a git repository:
https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent  
https://docs.gitlab.com/ee/ssh/  
https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key/
