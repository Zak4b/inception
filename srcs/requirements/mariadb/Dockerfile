ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

RUN		apt-get -y update && \
    	apt-get -y install mariadb-server && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

ENTRYPOINT