#use this compiler:
CC=gcc
CC_OPTIONS=-v -Wall -W -DGETPROTOBYNUMBER #GETPROTOENT # -DGETSERVBYNAME -DGETSERVBYPORT
TARGET=printUname.run
TOP_SRC=printUname.c

#Create macro for header files' incude directory
H_INCLUDES=./../../include
#Implements next wildcard: ./mylib/includes/h_files/*c
H_SOURCE=$(wildcard $(H_INCLUDES)/*.h)

all: clean
	$(CC) $(CC_OPTIONS) -I$(H_INCLUDES) $(TOP_SRC) -o $(TARGET)

clean : 
	rm -f *.run


