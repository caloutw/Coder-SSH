#Use ubuntu LTS.
FROM ubuntu:24.04

#Label
LABEL Author="caloutw"
LABEL Version="1.0.0"
LABEL Description="A multi-architecture SSH development environment based on Ubuntu 24.04. Supports both x86_64 and ARM64 architectures. Perfect for remote development with VS Code."
LABEL Maintainer="caloutw"
LABEL org.opencontainers.image.source="https://github.com/caloutw/Coder-SSH"
LABEL org.opencontainers.image.description="Multi-architecture SSH development environment"
LABEL org.opencontainers.image.licenses="MIT"

#User name and password.
ENV USERNAME=ubuntu
ENV PASSWORD=Abcd1234
ENV SUDO_PASSWORD=Abcd1234

ARG DEBIAN_FRONTEND=noninteractive

#Install required plugin.
RUN DEBIAN_FRONTEND=$DEBIAN_FRONTEND apt update -y && \
    DEBIAN_FRONTEND=$DEBIAN_FRONTEND apt install -y \
    openssh-server \
    curl \
    sudo \
    git \
    wget \
    ca-certificates \
    gnupg &&\
    rm -rf /var/lib/apt/lists/*

#Setting ssh.
COPY sshd_config /etc/ssh/sshd_config

#Configure /run/sshd dir
RUN mkdir -p /run/sshd

#Make cont dir
RUN mkdir /cont
WORKDIR /cont
COPY init.sh ./
COPY title ./
RUN chmod 777 ./init.sh

#Copy vscInit.sh
COPY vscInit.sh ./
RUN chmod 777 ./vscInit.sh
COPY vscInit_README.md ./

#This docker will use 22 port.
EXPOSE 22

#init.
CMD ["/cont/init.sh"]