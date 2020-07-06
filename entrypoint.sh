#!/bin/bash
#显示时间
date
#bash <(curl -fsSL https://raw.githubusercontent.com/P3TERX/aria2.conf/master/tracker.sh) "/etc/ct/.aria2/aria2.conf"
rcgo --conf-path=/etc/ct/.aria2/aria2.conf -D
tail -f /dev/null
