#!/bin/sh
rcgo --conf-path=/etc/ct/.aria2/aria2.conf -D
nginx
tail -f /dev/null
