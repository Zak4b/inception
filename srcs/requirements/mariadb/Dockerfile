ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

RUN		apt -y update && \
    	apt -y install mariadb-server && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

ENTRYPOINT