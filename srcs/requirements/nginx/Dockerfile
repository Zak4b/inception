ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

RUN		apt update -y && \
		apt install -y nginx openssl curl && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]