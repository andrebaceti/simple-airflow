#!/bin/bash
ssh-keyscan ${GIT_SERVER}  >> ~/.ssh/known_hosts

rm -Rf /airflow/dags/*

cd /airflow/dags/
git clone ${GIT_REPOSITORY}

######################
# Start cron process #
service cron start
