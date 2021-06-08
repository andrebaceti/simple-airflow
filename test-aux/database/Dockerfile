FROM andrebaceti/regen-timescale-db:0.3

ENV POSTGRES_PASSWORD pumpwood
ENV POSTGRES_USER pumpwood
ENV POSTGRES_DB pumpwood
ENV APP_NAME pumpwood-airflow-app

EXPOSE 5432:5432

COPY db_dump/database.sql /docker-entrypoint-initdb.d/database.sql
RUN chmod 777 -R /docker-entrypoint-initdb.d/
