source version
PGPASSWORD=pumpwood pg_dump --disable-triggers -h localhost -p 5432 -U pumpwood --superuser pumpwood > db_dump/database.sql
docker build -t andrebaceti/test-db-simple-airflow:$VERSION .
rm db_dump/database.sql
