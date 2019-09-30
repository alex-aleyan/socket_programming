#use this compiler:
CC=gcc
CC_OPTIONS=-v -Wall -W 
TARGET=streamClient.run
TOP_SRC=streamClient.c

#Create macro for header files' incude directory
H_INCLUDES=./../../include
#Implements next wildcard: ./mylib/includes/h_files/*c
H_SOURCE=$(wildcard $(H_INCLUDES)/*.h)

all: 
#	gcc -v -Wall -W -I./../../include servent.c -o servent.run
	$(CC) $(CC_OPTIONS) -I$(H_INCLUDES) $(TOP_SRC) -o $(TARGET)

clean : 
	rm -f $(TARGET)


