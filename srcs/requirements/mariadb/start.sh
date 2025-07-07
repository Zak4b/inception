#! /bin/sh
set -e -u

if [ ! -f "/var/lib/mysql/${DB_NAME}" ]; then
	mysqld_safe &
	sleep 5

	echo "DROP USER IF EXISTS 'root'@'%';" > init.sql
	echo "CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" >> init.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" >> init.sql
	echo "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;" >> init.sql
	echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '123${DB_USER_PASS}';" >> init.sql
	echo "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';" >> init.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> init.sql
	echo "FLUSH PRIVILEGES;" >> init.sql

	echo "Initializing database..."
	mariadb < init.sql

	if [ $? -eq 0 ]; then
		echo -e "\e[32mDatabase ${DB_NAME} created successfully\e[0m"
	else
		echo -e "\e[31mFailed to create database.\e[0m" && exit 1
	fi

	rm init.sql
	killall mysqld_safe
	wait
fi
exec mysqld