ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

RUN		apt update -y && \
		apt install -y curl zip unzip sudo php7.4 php7.4-fpm php7.4-mysql php7.4-gd php7.4-xml php7.4-curl php7.4-mbstring php7.4-zip mariadb-client && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

RUN curl -o /tmp/latest.tar.gz https://wordpress.org/wordpress-6.8.1.tar.gz
RUN tar -xzf /tmp/latest.tar.gz -C /tmp
RUN mkdir -p /var/www/html
RUN cp -r /tmp/wordpress/* /var/www/html
RUN rm -rf /tmp/latest.tar.gz /tmp/wordpress

COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /var/www/html
ENTRYPOINT [ "/start.sh" ]