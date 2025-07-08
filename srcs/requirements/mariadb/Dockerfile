ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
# RUN adduser --disabled-password --gecos "" app
# USER app
ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_ROOT_PASS=${DB_ROOT_PASS}
ENV DB_USER_PASS=${DB_USER_PASS}

RUN		apt -y update && \
    	apt -y install --no-install-recommends mariadb-server && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql && chown mysql:mysql /var/lib/mysql && chmod 750 /var/lib/mysql

EXPOSE 3306

HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
	CMD mysqladmin ping --silent || exit 1

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]