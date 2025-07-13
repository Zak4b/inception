#!/bin/bash
set -u

if [ ! -f "/var/lib/mysql/$DB_NAME" ]; then
    mysqld_safe &
    sleep 5

    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USER_PASS}';"
    # mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
    mariadb -e "FLUSH PRIVILEGES;"

    mariadb-admin -u root -p"$DB_ROOT_PASS" shutdown
fi
killall mysqld_safe
wait

exec mysqld_safe