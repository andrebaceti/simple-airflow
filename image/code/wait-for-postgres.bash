#!/bin/bash
set -e

until PGPASSWORD=${DB_PASSWORD} psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USERNAME" -c '\q'; do
  >&2 echo "Postgres is unavailable DB_HOST:${DB_HOST}, DB_PORT:${DB_PORT}, DB_USERNAME:${DB_USERNAME}: - sleeping"
  sleep 1
done
