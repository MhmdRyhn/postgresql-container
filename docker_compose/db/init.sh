#!/bin/bash

set -x
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $(echo ${DB_USER}) WITH PASSWORD '$(echo ${DB_USER_PASSWORD})';
    CREATE DATABASE $(echo ${DB_NAME});
    GRANT ALL PRIVILEGES ON DATABASE $(echo ${DB_NAME}) TO $(echo ${DB_USER});
EOSQL
