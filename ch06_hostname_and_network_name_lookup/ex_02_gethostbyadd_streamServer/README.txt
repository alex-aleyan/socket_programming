to run ex01 do: 
1. 
  ./streamServer.run &
  telnet 127.0.0.1 9099

  ./streamServer.run '*' &
  telnet 192.168.40.14 9099
  telnet localhost 9099

  ./streamServer.run 192.168.40.14 &
  telnet 192.168.40.14 9099


./streamServer.run 127.0.01 9099
