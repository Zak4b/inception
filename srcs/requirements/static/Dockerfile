ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="nginx"
ARG TMP_PKG=""

RUN apt -y update && apt -y install --no-install-recommends ${PKG}

COPY nginx.conf /etc/nginx/
EXPOSE 8080

RUN apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["nginx", "-g", "daemon off;"]