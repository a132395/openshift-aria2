#FROM alpine:latest
#FROM debian:latest
FROM centos:centos7
#RUN apk update
#更新源
RUN yum update -y
#RUN apt-get -y update && apt-get -y upgrade
#RUN apk add  --no-cache --virtual .build-deps ca-certificates wget curl unzip git bash git
RUN yum -y install wget
RUN yum -y install curl
RUN yum -y install ca-certificates
RUN yum -y install git
RUN yum -y install unzip
RUN yum -y install bash
RUN yum -y install jq


#RUN apt install wget -y
#RUN apt install curl -y
#RUN apt install git -y
#RUN apt install unzip -y
#RUN apt install bash -y
#RUN apt install jq -y
RUN mkdir /etc/ct
RUN chgrp -R 0 /etc/ct
RUN chmod -R g+rwX /etc/ct


#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#同步系统时间
#RUN apk add tzdata
#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#RUN echo "Asia/Shanghai" > /etc/timezone
#RUN apk del tzdata

RUN wget -P /etc/ct https://github.com/P3TERX/aria2-builder/releases/download/1.35.0_2020.06.13/aria2-1.35.0-static-linux-amd64.tar.gz
RUN tar -zxvf /etc/ct/aria2-1.35.0-static-linux-amd64.tar.gz -C /usr/bin
RUN rm -r /etc/ct/aria2-1.35.0-static-linux-amd64.tar.gz
RUN chmod +x /usr/bin/aria2c

RUN wget https://github.com/rclone/rclone/releases/download/v1.52.2/rclone-v1.52.2-linux-amd64.zip
RUN unzip rclone-v1.52.2-linux-amd64.zip
RUN mv /rclone-v1.52.2-linux-amd64/rclone /usr/bin/rclone
RUN rm -r rclone-v1.52.2-linux-amd64.zip
RUN rm -rf rclone-v1.52.2-linux-amd64/
RUN chmod +x /usr/bin/rclone

ADD .rclone.conf /root/.config/rclone/rclone.conf

RUN mkdir /root/.aria2

ADD aria2.conf /root/.aria2/aria2.conf

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/clean.sh
RUN chmod +x /root/.aria2/clean.sh

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/upload.sh
RUN chmod +x /root/.aria2/upload.sh

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/delete.sh
RUN chmod +x /root/.aria2/delete.sh

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/core
RUN chmod +x /root/.aria2/core

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/move.sh
RUN chmod +x /root/.aria2/move.sh

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/dht.dat

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/dht6.dat


RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/script.conf

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/rclone.env

RUN touch /root/.aria2/aria2.session
RUN touch /root/.aria2/aria2.log
RUN touch /root/.aria2/autoupload.log



ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080 51413
ENTRYPOINT ["/entrypoint.sh"]
