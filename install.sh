#!/usr/bin/env bash
set -e

apt-get update
apt install postgresql postgresql-client -y

sed -i -e 's/#listen_addresses/listen_addresses/' /etc/postgresql/11/main/postgresql.conf
systemctl restart postgresql


su -s /bin/bash postgres -c ./create-database-and-user.sh


