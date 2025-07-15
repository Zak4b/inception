#!/bin/bash
set -e -u
CONFIG_OK=1
if [ ! -f wp-config.php ]; then
	CONFIG_OK=0
    curl -O https://wordpress.org/wordpress-6.8.1.tar.gz
    tar -xzf wordpress-6.8.1.tar.gz --strip-components=1
    rm wordpress-6.8.1.tar.gz
    echo -e "\e[32mOK\e[0m"
	wp config create \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_USER_PASS"\
		--dbhost="mariadb" \
		--path=/var/www \
		--allow-root

	wp core install \
		--url="$DOMAIN_NAME" \
		--title="Inception asene" \
		--admin_user="$WP_ADMIN_LOGIN" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root

	wp user create "$WP_USER_LOGIN" "$WP_USER_EMAIL" \
		--role=author \
		--user_pass="$WP_USER_PASSWORD" \
		--allow-root
	
	wp config set WP_REDIS_HOST redis --allow-root
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root
	CONFIG_OK=1
fi
if [ "$CONFIG_OK" -eq 0 ]; then
	echo Error Durring config
	exit 1
fi
if [ ! -f /var/www/wp-content/object-cache.php ]; then
    cp /var/www/wp-content/plugins/redis-cache/includes/object-cache.php /var/www/wp-content/object-cache.php
fi
exec php-fpm7.4 -F