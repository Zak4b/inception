ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="php7.4 php7.4-fpm php7.4-mysql php-redis mariadb-client curl ca-certificates unzip"
RUN apt -y update && apt -y install --no-install-recommends ${PKG}

RUN mkdir -p /run/php
COPY php-fpm.conf /etc/php/7.4/fpm/
COPY www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp
RUN chmod -R 777 /var/www
EXPOSE 9000

COPY start.sh /start.sh
RUN chmod +x /start.sh
RUN apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/start.sh" ]