source docker-versions.sh

docker push andrebaceti/test-db-simple-airflow:$TEST_DB_AIRFLOW
docker push andrebaceti/simple-airflow:$AIRFLOW
