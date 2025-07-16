ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="nginx git ca-certificates"
ARG TMP_PKG=""

RUN apt -y update && apt -y install --no-install-recommends ${PKG}

COPY nginx.conf /etc/nginx/
WORKDIR /var/www
RUN rm -rf * && git clone https://github.com/Zak4b/2.5d.git .

EXPOSE 80
RUN apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["nginx", "-g", "daemon off;"]