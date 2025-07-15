ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="redis"
ARG TMP_PKG=""
RUN apt -y update && apt -y install --no-install-recommends ${PKG}

COPY redis.conf /etc/redis/

EXPOSE 6379

RUN apt remove -y ${TMP_PKG} && apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "redis-server", "--protected-mode", "no" ]