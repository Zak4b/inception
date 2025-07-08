ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
# RUN adduser --disabled-password --gecos "" app
# USER app

RUN		apt update -y && \
		apt install -y nginx openssl curl gettext-base && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

ARG LOGIN
ARG DOMAIN_NAME

RUN mkdir -p /etc/nginx/ssl /www

ENV SSL_CERT=/etc/nginx/ssl/inception.crt
ENV SSL_KEY=/etc/nginx/ssl/inception.key

RUN openssl req -x509 -nodes -days 365 \
	-out ${SSL_CERT} \ 
	-keyout ${SSL_KEY} \
	-subj "/C=FR/ST=IDF/L=Perpignan/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${LOGIN}"

COPY nginx.conf.template /etc/nginx/nginx.conf.template
RUN envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
# RUN chown -R app:app /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]