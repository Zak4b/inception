ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
# RUN adduser --disabled-password --gecos "" app
# USER app

RUN		apt update -y && \
		apt install -y nginx openssl curl && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

ARG LOGIN
ARG DOMAIN_NAME

RUN mkdir -p /etc/nginx/cert /etc/nginx/tsl_key

RUN openssl req -x509 -nodes -days 365 \
	-out /etc/nginx/cert/inception.crt \ 
	-keyout /etc/nginx/tsl_key/inception.key \
	-subj "/C=FR/ST=IDF/L=Perpignan/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${LOGIN}"

COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
# RUN chown -R app:app /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]