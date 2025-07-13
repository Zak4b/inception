ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

RUN		apt update -y && \
		apt install -y curl unzip sudo php7.4 php7.4-fpm php7.4-mysql mariadb-client && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php
COPY php-fpm.conf /etc/php/7.4/fpm/
COPY www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]