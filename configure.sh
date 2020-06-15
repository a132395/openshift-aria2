#!/bin/sh
rcgo --conf-path=/etc/ct/.aria2/aria2.conf -D

nohup /etc/ct/sunny clientid 5ca48645cdcdeda5 >/etc/ct/id.txt 2>&1 &

/etc/ct/cloudreve
tail -f /dev/null
