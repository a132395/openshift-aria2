#FROM alpine:latest
FROM debian:latest
#RUN apk update
#更新源
RUN apt-get -y update && apt-get -y upgrade
#RUN apk add  --no-cache --virtual .build-deps ca-certificates wget curl unzip git bash git

RUN apt install wget -y
RUN apt install curl -y
RUN apt install git -y
RUN apt install unzip -y
RUN apt install bash -y
RUN apt install aria2 -y
RUN mkdir /etc/ct
RUN chgrp -R 0 /etc/ct
RUN chmod -R g+rwX /etc/ct


RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#同步系统时间
#RUN apk add tzdata
#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#RUN echo "Asia/Shanghai" > /etc/timezone
#RUN apk del tzdata

#RUN wget -P /etc/ct https://github.com/P3TERX/aria2-builder/releases/download/1.35.0_2020.06.13/aria2-1.35.0-static-linux-amd64.tar.gz
#RUN tar -zxvf /etc/ct/aria2-1.35.0-static-linux-amd64.tar.gz -C /usr/bin
#RUN rm -r /etc/ct/aria2-1.35.0-static-linux-amd64.tar.gz
#RUN chmod +x /usr/bin/aria2c

RUN wget https://github.com/rclone/rclone/releases/download/v1.52.2/rclone-v1.52.2-linux-amd64.zip
RUN unzip rclone-v1.52.2-linux-amd64.zip
RUN mv /rclone-v1.52.2-linux-amd64/rclone /usr/bin/rclone
RUN rm -r rclone-v1.52.2-linux-amd64.zip
RUN rm -rf rclone-v1.52.2-linux-amd64/
RUN chmod +x /usr/bin/rclone
ADD .rclone.conf /root/.rclone.conf

ADD aria2.conf /etc/ct/.aria2/aria2.conf

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/clean.sh
RUN chmod +x /etc/ct/.aria2/clean.sh

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/upload.sh
RUN chmod +x /etc/ct/.aria2/upload.sh

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/delete.sh
RUN chmod +x /etc/ct/.aria2/delete.sh

RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/dht.dat
RUN chmod +x /etc/ct/.aria2/dht.dat
RUN wget -P /etc/ct/.aria2 https://p3terx.github.io/aria2.conf/dht6.dat
RUN chmod +x /etc/ct/.aria2/dht6.dat
RUN touch /etc/ct/.aria2/aria2.session
RUN touch /etc/ct/.aria2/aria2.log
RUN touch /etc/ct/.aria2/autoupload.log



ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080 51413
ENTRYPOINT ["/entrypoint.sh"]
