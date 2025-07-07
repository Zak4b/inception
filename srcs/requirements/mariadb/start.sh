#! /bin/sh
set -e -u

if [ ! -f "/var/lib/mysql/${DB_NAME}" ]; then
	mysqld_safe &
	sleep 5

	echo "Initializing database..."

    mariadb <<EOF
DROP USER IF EXISTS 'root'@'%';
CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '123${DB_USER_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

	if [ $? -eq 0 ]; then
		echo -e "\e[32mDatabase ${DB_NAME} created successfully\e[0m"
	else
		echo -e "\e[31mFailed to create database.\e[0m" && exit 1
	fi

	killall mysqld_safe
	wait
fi
exec mysqld