#!/bin/bash
# Coping keys to ~/.ssh directory
# Kubernets does not permit mouting single file secrets to pods
# so it is nece
cp /ssh_keys/id_rsa ~/.ssh/
cp /ssh_keys/id_rsa.pub ~/.ssh/
chown root:root ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub

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
