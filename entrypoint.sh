#!/bin/sh
bash <(curl -fsSL git.io/tracker.sh) "/etc/ct/.aria2/aria2.conf"
rcgo --conf-path=/etc/ct/.aria2/aria2.conf
#tail -f /dev/null
