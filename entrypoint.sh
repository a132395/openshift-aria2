#!/bin/bash
#显示时间
date
bash <(curl -fsSL https://raw.githubusercontent.com/P3TERX/aria2.conf/master/tracker.sh) "/root/.aria2/aria2.conf"
sed -i "s/#export RCLONE_CONFIG=$HOME/.config/rclone/rclone.conf/export RCLONE_CONFIG=$HOME/.config/rclone/rclone.conf/g" /root/.aria2/rclone.env
aria2c --conf-path=/root/.aria2/aria2.conf
