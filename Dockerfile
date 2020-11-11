
FROM ubuntu:20.04

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND=noninteractive
MAINTAINER wenchi0920@gmail.com

WORKDIR /tmp

COPY crontab.txt /tmp/crontab.txt

RUN echo "deb http://mirror01.idc.hinet.net/ubuntu/ bionic main restricted" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --fix-missing \
            python3 python3-pip gcc python3-dev locales tzdata bash-completion \
    && apt-get install --fix-missing -y python3-pip rclone \
    && apt-get install --fix-missing -y cron sudo curl htop \
    && apt-get install -y --fix-missing \
            less rsync vim wget \
            cron sudo curl htop \
            procps util-linux \
            git xjobs net-tools \
            telnet openssh-client \
            python3-setuptools golang unzip \
            autossh openssh-server \
            uuid-runtime \
            supervisor \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && echo "zh_TW BIG5" > /etc/locale.gen \
    && echo "zh_TW.UTF-8 UTF-8" > /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get -y autoremove ; apt-get clean ; rm -rf /var/lib/apt/* \
    && crontab /tmp/crontab.txt && rm -rfv /tmp/crontab.txt


