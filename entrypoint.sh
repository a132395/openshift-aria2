#!/bin/bash
#显示时间
date
bash <(curl -fsSL https://raw.githubusercontent.com/P3TERX/aria2.conf/master/tracker.sh) "/root/.aria2/aria2.conf"
sed -i "s/drive-name=OneDrive/drive-name=gd/g" /root/.aria2/script.conf

sed -i "s/user-agent=Mozilla/#user-agent=Mozilla/g" /root/.aria2/aria2.conf
sed -i "s/#user-agent=qBittorrent/user-agent=qBittorrent/g" /root/.aria2/aria2.conf
aria2c --conf-path=/root/.aria2/aria2.conf
