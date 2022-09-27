FROM python:3.8.5-buster

#################################
# Setting Environment Variables #
# Postgres Connection
ENV DB_DIALECT="postgres"
ENV DB_USERNAME="pumpwood"
ENV DB_PASSWORD="pumpwood"
ENV DB_DATABASE="pumpwood"
ENV DB_HOST="test-db-airflow"
ENV DB_PORT="5432"

# RabbitMQ Queue for ETL worker
ENV RABBITMQ_USERNAME="pumpwood"
ENV RABBITMQ_PASSWORD="pumpwood"
ENV RABBITMQ_HOST="rabbitmq-main"
ENV RABBITMQ_PORT="5672"

# Core config
ENV AIRFLOW_HOME="/airflow"

# Airflow executor
ENV AIRFLOW__CORE__EXECUTOR="CeleryExecutor"

# Airflow folders
ENV AIRFLOW__CORE__DAGS_FOLDER="/airflow/dags/"
ENV AIRFLOW__CORE__PLUGINS_FOLDER="/airflow/plugins/"
ENV AIRFLOW__LOGGING__BASE_LOG_FOLDER="/airflow/logs/"
ENV AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY="/airflow/child_process_log/"

# Webserver information
ENV AIRFLOW__WEBSERVER__BASE_URL="http://localhost:8080/"
ENV AIRFLOW__WEBSERVER__WEB_SERVER_HOST="0.0.0.0"
ENV AIRFLOW__WEBSERVER__WEB_SERVER_PORT="8080"
ENV AIRFLOW__WEBSERVER__SECRET_KEY_SECRET="o1vZ9ms0lEu2NaX7CXgfsw=="

###################
# Git information #
# ENV GIT_SERVER
# ENV GIT_REPOSITORY
ENV GIT_BRANCH="master"


########################
# Getting repositories #
# Installing lsb-release to make life easier :)
RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
RUN apt-get -y upgrade

# Postgres
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add -
RUN RELEASE=$(lsb_release -cs) && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ ${RELEASE}"-pgdg main | \
  tee  /etc/apt/sources.list.d/pgdg.list

# SQLServer
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Installing cronjob to update Dags
RUN apt-get install -y cron

#######################################################
# Updating system and installing general dependencies #
RUN apt-get -y update && apt-get upgrade -y && \
  apt-get -y autoremove && apt-get -y autoclean
RUN apt-get install -y --no-install-recommends \
        freetds-bin \
        ldap-utils \
        libffi6 \
        libsasl2-2 \
        libsasl2-modules \
        libssl1.1 \
        locales  \
        lsb-release \
        sasl2-bin \
        sqlite3 \
        unixodbc \
        curl


###############################
# Installing Postgres Drivers #
RUN apt-get -y install libpq-dev postgresql-client postgresql-client-common
RUN apt-get install -y --force-yes curl


################################
# Installing SQL Sever Drivers #
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN apt-get install -y unixodbc-dev
RUN apt-get install -y libgssapi-krb5-2


############################
# Installing Redis Drivers #
RUN apt-get -y install redis-server


##################################
# Installing python dependencies #
RUN apt-get -y install python3 python3-dev python3-pip python3-wheel \
  libsasl2-dev gcc libsasl2-dev libldap2-dev libssl-dev


#######################
# Python requirements #
COPY requirements/requirements.txt ./requirements/
COPY requirements/constraints.txt ./requirements/
RUN pip3 install --upgrade pip
RUN pip3 install --use-deprecated=legacy-resolver -r \
  /requirements/requirements.txt -c /requirements/constraints.txt


#########################################
# Creating directories and coping codes #
RUN mkdir -p /airflow/dags/
RUN mkdir -p /airflow/logs/
RUN mkdir -p /airflow/plugins/
RUN mkdir -p /airflow/child_process_log/
COPY code /airflow

#####################################
# Creating directories for ssh keys #
RUN mkdir -p /ssh_keys/
RUN mkdir -p /root/.ssh/

#############################
# Coping git update cronjob #
ADD cron/update_git /etc/cron.d/update_git
RUN crontab /etc/cron.d/update_git

###########################################################
# Add a requirement to be installed every container start #
ADD requirements/run_requirements.txt /requirements/requirements.txt

###################################
# Default entrypoint as webserver #
WORKDIR /airflow/
CMD ["bash", "/airflow/start_airflow__webserver.bash"]
