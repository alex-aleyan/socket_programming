#use this compiler:
CC=gcc
CC_OPTIONS=-v -Wall -W 
SERVER_TARGET=streamServer.run
SERVER_SRC=streamServer.c
CLIENT_TARGET=streamClient.run
CLIENT_SRC=streamClient.c


# Create macro for header files' incude directory
#H_INCLUDES=./../../include
# Implements next wildcard: ./mylib/includes/h_files/*c
#H_SOURCE=$(wildcard $(H_INCLUDES)/*.h)
# Alternatively, use C_INCLUDE_PATH and CPLUS_INCLUDE_PATH in bashrc!

all: server client

server:
	#$(CC) $(CC_OPTIONS) -I$(H_INCLUDES) $(SERVER_SRC) -o $(SERVER_TARGET)
	$(CC) $(CC_OPTIONS) $(SERVER_SRC) -o $(SERVER_TARGET)

client:
	#$(CC) $(CC_OPTIONS) -I$(H_INCLUDES) $(CLIENT_SRC) -o $(CLIENT_TARGET)
	$(CC) $(CC_OPTIONS) $(CLIENT_SRC) -o $(CLIENT_TARGET)

clean : 
	rm -f *.run *.log
