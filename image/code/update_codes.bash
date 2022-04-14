cd /airflow/dags/git_dags

git pull
git checkout ${GIT_BRANCH}

currentDate='date'
date +"%Y-%m-%d %T" > /gitupdate_status
