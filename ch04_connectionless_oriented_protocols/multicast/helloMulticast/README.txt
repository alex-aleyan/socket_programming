ip maddr show
ifconfig eth0
grep CONFIG_IP_MULTICAST /usr/src/kernels/2.6.32-696.el6.x86_64/.config

ifconfig eth0 multicast
ifconfig eth0 -multicast


#on box02:
./dgramReceive.run
#on box01:
./dgramTransmit.run

sudo watch "netstat -neopa | grep 'dgram\|Recv-Q'"
