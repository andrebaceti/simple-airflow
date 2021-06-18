#!/bin/bash

# Setting known_hosts so accepting ssh keys is automatic
ssh-keyscan ${GIT_SERVER}  >> ~/.ssh/known_hosts

# Cleaning dags folders
rm -Rf /airflow/dags/*

# Clonning repository and setting correct branch
cd /airflow/dags/
git clone ${GIT_REPOSITORY} git_dags

cd git_dags
git checkout ${GIT_BRANCH}
git pull

######################
# Start cron process #
service cron start
