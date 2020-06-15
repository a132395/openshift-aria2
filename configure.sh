#!/bin/sh
rcgo --conf-path=/etc/ct/.aria2/aria2.conf -D
nginx
/etc/ct/sunny clientid 5ca48645cdcdeda5
tail -f /dev/null
