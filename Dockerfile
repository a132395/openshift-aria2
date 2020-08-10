#FROM alpine:latest
FROM debian:latest
#FROM archlinux:latest
#RUN apk update
#更新源
RUN apt-get -y update && apt-get -y upgrade
#RUN apk add  --no-cache --virtual .build-deps ca-certificates wget curl unzip git bash git jq
#RUN echo y | pacman -Syu
#RUN echo y | pacman -S wget git curl unzip bash jq rclone

RUN apt install -y wget curl git unzip bash jq rclone

RUN mkdir /etc/ct
RUN chgrp -R 0 /etc/ct
RUN chmod -R g+rwX /etc/ct


RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#同步系统时间
#RUN apk add tzdata
#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#RUN echo "Asia/Shanghai" > /etc/timezone
#RUN apk del tzdata

RUN wget -P /etc/ct https://github.com/P3TERX/aria2-builder/releases/download/1.35.0_2020.06.13/aria2-1.35.0-static-linux-amd64.tar.gz
RUN tar -zxvf /etc/ct/aria2-1.35.0-static-linux-amd64.tar.gz -C /usr/bin
RUN rm -r /etc/ct/aria2-1.35.0-static-linux-amd64.tar.gz
RUN chmod +x /usr/bin/aria2c

RUN wget -P /usr/bin https://github.com/caddyserver/caddy/releases/download/v1.0.4/caddy_v1.0.4_linux_amd64.tar.gz
RUN tar -zxvf /usr/bin/caddy_v1.0.4_linux_amd64.tar.gz -C /usr/bin
RUN chmod +x /usr/bin/caddy

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

#RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/dht6.dat


RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/script.conf

RUN wget -P /root/.aria2 https://p3terx.github.io/aria2.conf/rclone.env

RUN touch /root/.aria2/aria2.session
RUN touch /root/.aria2/aria2.log
RUN touch /root/.aria2/upload.log

ADD Caddyfile /etc/Caddyfile
RUN mkdir /wwwroot
RUN git clone https://github.com/xiongbao/we.dog
RUN mv we.dog/* /wwwroot
RUN rm -rf /we.dog

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80 8080 51413
ENTRYPOINT ["/entrypoint.sh"]
