#!/usr/bin/env bash
set -e
source CONFIG

apt-get update
apt install postgresql postgresql-client -y

sed -i -e 's/#listen_addresses/listen_addresses/' /etc/postgresql/11/main/postgresql.conf
systemctl restart postgresql

# Just to avoid an error message because user postgres operating in roots home directory
cd /tmp

su -s /bin/bash postgres
psql -v ON_ERROR_STOP=1  <<-EOSQL
    CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';
    CREATE DATABASE $POSTGRES_DATABASE;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DATABASE TO $POSTGRES_USER;
EOSQL

