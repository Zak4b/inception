ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
ARG PKG="vsftpd"
RUN apt -y update && apt -y install --no-install-recommends ${PKG}

ARG FTP_USER
ARG FTP_PASS

COPY .conf /
RUN mkdir -p /var/run/vsftpd/empty /home/ftpuserds /data
RUN env && useradd -m ${FTP_USER} && echo "${FTP_USER}:${FTP_PASS}" | chpasswd

RUN chmod -R 777 /data

EXPOSE 20 21 21100-21110

RUN apt clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "vsftpd", "/.conf" ]