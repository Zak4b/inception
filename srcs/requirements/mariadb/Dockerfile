ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="mariadb-server"
ARG TMP_PKG=""
RUN apt -y update && apt -y install --no-install-recommends ${PKG}

RUN mkdir -p /var/lib/mysql

COPY 50-server.cnf /etc/mysql/mariadb.conf.d

EXPOSE 3306

HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
CMD mysqladmin ping --silent || exit 1

COPY start.sh /start.sh
RUN chmod +x /start.sh  
RUN apt remove -y ${TMP_PKG} && apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/start.sh" ]