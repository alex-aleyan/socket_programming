#on box02:
./dgramReceive.run
#on box01:
./dgramTransmit.run

sudo watch "netstat -neopa | grep 'dgram\|Recv-Q'"
