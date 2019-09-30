#use this compiler:
CC=gcc
CC_OPTIONS=-v -Wall -W -DGETPROTOBYNUMBER #GETPROTOENT # -DGETSERVBYNAME -DGETSERVBYPORT
TARGET=servent.run
TOP_SRC=servent.c

#Create macro for header files' incude directory
H_INCLUDES=./../../include
#Implements next wildcard: ./mylib/includes/h_files/*c
H_SOURCE=$(wildcard $(H_INCLUDES)/*.h)

all: clean
#	gcc -v -Wall -W -I./../../include servent.c -o servent.run
	$(CC) $(CC_OPTIONS) -I$(H_INCLUDES) $(TOP_SRC) -o $(TARGET)

clean : 
	rm -f $(TARGET)


