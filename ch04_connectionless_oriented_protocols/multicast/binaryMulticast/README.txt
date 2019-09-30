# write any hex data you desire to data.bin:
[cli]$ ./asci2bin f0f1fafbfcfdfeff > data.bin

# verify the data was written:
[cli]$ hexdump -C data.bin
  00000000  f0 f1 fa fb fc fd fe ff                           |........|
    0000000

ip maddr show
ifconfig eth0
grep CONFIG_IP_MULTICAST /usr/src/kernels/2.6.32-696.el6.x86_64/.config

ifconfig eth0 multicast
ifconfig eth0 -multicast

# Transmit from Calzone:
./dgramTransmit.run "192.168.40.153"

#on box02:
./dgramReceive.run
#on box01:
./dgramTransmit.run

sudo watch "netstat -neopa | grep 'dgram\|Recv-Q'"
