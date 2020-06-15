#!/bin/sh
rcgo --conf-path=/etc/ct/.aria2/aria2.conf -D

setsid /etc/ct/sunny clientid 5ca48645cdcdeda5 &

/etc/ct/cloudreve
tail -f /dev/null
