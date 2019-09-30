#use this compiler:
CC=gcc
CC_OPTIONS=-v -Wall -W -D_GNU_SOURCE
CC_DEBUG_OPTIONS=-v -g --save-temps -Wall -W -D_GNU_SOURCE -W -DGETPROTOBYNUMBER -DDEBUG
SERVER_TARGET=dgramReceive.run
SERVER_SRC=dgramReceive.c
CLIENT_TARGET=dgramTransmit.run
CLIENT_SRC=dgramTransmit.c

#Create macro for header files' incude directory
#H_INCLUDES=./../../include
#Implements next wildcard: ./mylib/includes/h_files/*c
#H_SOURCE=$(wildcard $(H_INCLUDES)/*.h)


all: server client
alldebug: debug_server debug_client

debug_server:
	$(CC) $(CC_DEBUG_OPTIONS) $(SERVER_SRC) -o $(SERVER_TARGET)

debug_client:
	$(CC) $(CC_DEBUG_OPTIONS) $(CLIENT_SRC) -o $(CLIENT_TARGET)


server:
	$(CC) $(CC_OPTIONS) $(SERVER_SRC) -o $(SERVER_TARGET)
#	$(CC) $(CC_OPTIONS) -I/usr/include/linux $(SERVER_SRC) -o $(SERVER_TARGET)
#$(CC) $(CC_OPTIONS) -I/usr/include/netinet $(SERVER_SRC) -o $(SERVER_TARGET)


client:
	$(CC) $(CC_OPTIONS) $(CLIENT_SRC) -o $(CLIENT_TARGET)
  

clean : 
#rm -f $(SERVER_TARGET) $(CLIENT_TARGET)
	rm -f *.run *.i *.o *.s *.core
