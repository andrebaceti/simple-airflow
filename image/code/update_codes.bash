cd /airflow/dags/git_dags

git checkout ${GIT_BRANCH}
git pull

currentDate='date'
date +"%Y-%m-%d %T" > /gitupdate_status
