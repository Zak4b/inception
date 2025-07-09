ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

RUN		apt update -y && \
		apt install -y curl unzip sudo php7.4 php7.4-fpm php7.4-mysql mariadb-client && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

WORKDIR /var/www
RUN curl -O https://wordpress.org/wordpress-6.8.1.tar.gz && \
    tar -xzf wordpress-6.8.1.tar.gz && \
    rm wordpress-6.8.1.tar.gz

RUN mkdir -p /run/php && sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf	
EXPOSE 9000

ENTRYPOINT [ "php-fpm7.4", "-F" ]