to run ex01 do: 

./streamServer.run 127.0.0.1 9099
./streamClient.run 127.0.0.1 9099

#where 192.168.84.152 is the IP of the server's eth4 interface
#on box02:
./streamServer.run 192.168.40.185 9099
#on box01:
./streamClient.run 192.168.40.185 9099

#on box02:
./streamServer.run 0x00000000 9099
#on box01:
./streamClient.run 192.168.84.152


sudo watch "netstat -neopa | grep 'stream\|Recv-Q'"
