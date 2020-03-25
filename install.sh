#!/usr/bin/env bash
set -e

apt-get update
apt install postgresql postgresql-client -y

sed -i -e 's/#listen_addresses/listen_addresses/' /etc/postgresql/11/main/postgresql.conf
systemctl restart postgresql


su -s /bin/bash postgres
source CONFIG
# Just to avoid an error message because user postgres operating in roots home directory
cd /tmp
psql -v ON_ERROR_STOP=1  <<-EOSQL
    CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';
    CREATE DATABASE $POSTGRES_DATABASE;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DATABASE TO $POSTGRES_USER;
EOSQL

