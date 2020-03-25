#!/usr/bin/env bash
set -e
source CONFIG
# Just to avoid an error message because user postgres operating in roots home directory
cd /tmp
psql -v ON_ERROR_STOP=1  <<-EOSQL
    CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';
    CREATE DATABASE $POSTGRES_DATABASE;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DATABASE TO $POSTGRES_USER;
EOSQL