ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="vsftpd"
RUN apt -y update && apt -y install --no-install-recommends ${PKG}

COPY .conf /
RUN mkdir -p /var/run/vsftpd/empty /home/ftpuserds /data
RUN useradd -m fuser && echo "fuser:pass" | chpasswd

RUN chmod -R 777 /data

EXPOSE 20 21 21100-21110

RUN apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "vsftpd", "/.conf" ]