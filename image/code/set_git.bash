#!/bin/bash

# Setting known_hosts so accepting ssh keys is automatic
ssh-keyscan ${GIT_SERVER} > ~/.ssh/known_hosts

# Cleaning dags folders
rm -Rf /airflow/dags/*

# Clonning repository and setting correct branch
cd /airflow/dags/

echo "# Clonning repo"
git clone ${GIT_REPOSITORY} git_dags

cd git_dags
echo "# Pulling repo"
git pull

echo "# Checkout branch"
git checkout ${GIT_BRANCH}

######################
# Start cron process #
service cron start
