ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

RUN		apt update -y && \
		apt install -y curl sudo php7.4 php7.4-fpm php7.4-mysql php7.4-gd php7.4-xml php7.4-curl php7.4-mbstring php7.4-zip mariadb-client && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

ENTRYPOINT