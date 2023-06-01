#!/bin/sh
if [ ! -f /etc/apt-cacher-ng/acng.conf ]; then
    cp -a /tmp/acng/* /etc/apt-cacher-ng
fi
/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng ForeGround=0
tail -f /var/log/apt-cacher-ng/apt-cacher.err /var/log/apt-cacher-ng/apt-cacher.log
