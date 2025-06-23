ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

RUN		apt-get update -y && \
		apt-get install -y nginx openssl curl && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]