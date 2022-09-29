cd /airflow/dags/git_dags

git pull
git checkout ${GIT_BRANCH}

if [ -f "/airflow/dags/git_dags/requirements/requirements.txt" ]; then
    echo "Installing requirements.txt"
    pip install --requirement /airflow/dags/git_dags/requirements/requirements.txt --constraint /requirements/constraints.txt
fi

currentDate='date'
date +"%Y-%m-%d %T" > /gitupdate_status
