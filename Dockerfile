FROM alpine:latest
RUN apk update
RUN apk add  --no-cache --virtual .build-deps ca-certificates wget curl unzip git

RUN mkdir /etc/ct
RUN touch /etc/ct/config.json
RUN chgrp -R 0 /etc/ct
RUN chmod -R g+rwX /etc/ct
RUN wge -P /etc/ct https://github.com/cloudreve/Cloudreve/releases/download/3.1.1/cloudreve_3.1.1_linux_amd64.tar.gz
RUN tar -zxvf /etc/ct/cloudreve_3.1.1_linux_amd64.tar.gz
RUN chmod +x /etc/ct/cloudreve
RUN wget -P /etc/ct https://github.com/byxiaopeng/ads/raw/master/sunny
RUN chmod +x /etc/ct/sunny

#RUN wget -P /etc/ct https://github.com/byxiaopeng/goorm-v2ray/raw/master/v2ray
#RUN chmod +x /etc/ct/v2ray /etc/ct/v2ray
#RUN wget -P /etc/ct https://github.com/byxiaopeng/goorm-v2ray/raw/master/v2ctl
#RUN chmod +x /etc/ct/v2ctl
#RUN mv /etc/ct/v2ray /etc/ct/bash

RUN wget -P /usr/bin https://gd.cnm.workers.dev/amd64/aria2c
RUN chmod +x /usr/bin/aria2c
RUN mv /usr/bin/aria2c /usr/bin/rcgo
RUN wget -P /usr/bin https://gd.cnm.workers.dev/amd64/rcgd
RUN chmod +x /usr/bin/rcgd
ADD .rclone.conf /etc/ct/.rclone.conf

ADD aria2.conf /etc/ct/.aria2/aria2.conf

ADD autoupload.sh /etc/ct/.aria2/autoupload.sh
RUN chmod +x /etc/ct/.aria2/autoupload.sh

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/delete.aria2.sh
RUN chmod +x /etc/ct/.aria2/delete.aria2.sh

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/delete.sh
RUN chmod +x /etc/ct/.aria2/delete.sh

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/dht.dat
RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/dht6.dat
RUN touch /etc/ct/.aria2/aria2.session
RUN touch /etc/ct/.aria2/aria2.log



ADD configure.sh /configure.sh
RUN chmod +x /configure.sh

ENTRYPOINT ["sh", "/configure.sh"]

EXPOSE 5212
