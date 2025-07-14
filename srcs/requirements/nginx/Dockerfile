ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="nginx openssl curl gettext-base"
ARG TMP_PKG=""

RUN apt -y update && apt -y install --no-install-recommends ${PKG}

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
RUN envsubst '${SSL_CERT} ${SSL_KEY} ${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
EXPOSE 443

RUN apt remove -y ${TMP_PKG} && apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["nginx", "-g", "daemon off;"]