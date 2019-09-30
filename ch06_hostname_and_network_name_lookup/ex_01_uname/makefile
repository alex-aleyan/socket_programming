#use this compiler:
CC=gcc
CC_OPTIONS=-v -Wall -W -D_GNU_SOURCE -W -DGETPROTOBYNUMBER #GETPROTOENT # -DGETSERVBYNAME -DGETSERVBYPORT
CC_DEBUG_OPTIONS=-v -g --save-temps -Wall -W -D_GNU_SOURCE -W -DGETPROTOBYNUMBER #GETPROTOENT # -DGETSERVBYNAME -DGETSERVBYPORT
TARGET=printUname.run
TOP_SRC=printUname.c

#Create macro for header files' incude directory
H_INCLUDES=./../../include
#Implements next wildcard: ./mylib/includes/h_files/*c
H_SOURCE=$(wildcard $(H_INCLUDES)/*.h)

all: clean
	$(CC) $(CC_OPTIONS) -I$(H_INCLUDES) $(TOP_SRC) -o $(TARGET)

#In bash shell, make sure	to: "ulimit -c unlimited"
debug:
	$(CC) $(CC_DEBUG_OPTIONS) -I$(H_INCLUDES) $(TOP_SRC) -o $(TARGET)


clean : 
	rm -f *.run *.i *.o *.s
	rm -f core.*


