#!/bin/sh

export TERM=xterm
(nohup /usr/bin/tun2proxy-bin --setup $PROXY_COMMAND > /var/log/tun2proxy.log 2>&1) &

sleep 5
ip route del 128.0.0.0/1
ip route del 0.0.0.0/1

ip route del default

ip route add default via 10.0.0.1 dev tun0

sh -c "echo nameserver 127.0.0.11 > /etc/resolv.conf"

tail -f /var/log/tun2proxy.log
