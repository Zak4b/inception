ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="php7.4 php7.4-fpm php7.4-mysql curl ca-certificates"
ARG TMP_PKG=""
RUN apt -y update && apt -y install --no-install-recommends ${PKG}

RUN mkdir -p /run/php
COPY php-fpm.conf /etc/php/7.4/fpm/
COPY www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www/adminer
RUN curl -L -o index.php https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0-mysql.php

EXPOSE 9000

RUN apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "php-fpm7.4", "-F" ]