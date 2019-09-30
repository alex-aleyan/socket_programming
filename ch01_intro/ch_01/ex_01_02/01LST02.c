/* Listing 1.2:
 * *
 * * Example performing I/O on a Socket Pair:
 * */

// see /usr/include:
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>

int main(int argc,char **argv) 
{

int z;			/* Status return value */
int s[2];		/* Pair of sockets */
//char *cp;		/* A work pointer */
char readBuffer[80];	/* Work readBufferfer */
char writeBuffer[80];	/* Work readBufferfer */



// CREATE A SOCKET:
//z=0 if socketpair() successful, else -1
// socketpair(int domain, int type, int protocol, int fds[2])
z = socketpair(AF_LOCAL,SOCK_STREAM,0,s);

if ( z == -1 ) {
fprintf(stderr, "%s: socketpair(AF_LOCAL,SOCK_STREAM," "0)\n",
strerror(errno));
return 1; /* Failed */
}



// WRITE A MESSAGE TO SOCKER s[1]:
//     write(writeToFileDescriptor,pointerToBuffer,sizeOfMessage)
strcpy(writeBuffer,"Hello!");
z = write(s[1],writeBuffer,strlen(writeBuffer));

if ( z < 0 ) 
{
	fprintf(stderr,"%s: write(%d,\"%s\",%d)\n", strerror(errno),s[1],writeBuffer, (int) strlen(writeBuffer) );
	//fprintf(stderr,"%s: write(%d", strerror(errno),s[1]);
	//fprintf(stderr,"\"%s\",%d)\n", writeBuffer, (int) strlen(writeBuffer) );
	
	return 2; /* Failed write */
}

printf("Wrote message '%s' on s[2]\n",writeBuffer);



//READ FROM SOCKET  s[0]:
//read(readFromFileDescriptor,readBufferf, sizeOfBuf)
z = read(s[0],readBuffer,sizeof(readBuffer));

if ( z < 0 ) 
{
	fprintf(stderr,
	"%s: read(%d,readBuffer,%d)\n", (int) strerror(errno),s[0],sizeof(readBuffer));
	return 3; /* Failed read */
}

// Report received message:
readBuffer[z] = 0; /*set NUL terminate so printf d.n. read past readBuffer[z-1] element*/
printf("Received message '%s' from socket s[0]\n", readBuffer);



// SEND REPLY BACK TO s[1] FROM s[0]
strcpy(writeBuffer,"Go Away!");
z = write(s[0],writeBuffer, strlen(writeBuffer));

if ( z < 0 ) 
{
	fprintf(stderr,"%s: write(%d,\"%s\",%d)\n",(int) strerror(errno),s[0],writeBuffer,strlen(writeBuffer));
	return 4; /* Failed write */
}

printf("Wrote message '%s' on s[0]\n",writeBuffer);



//READ FROM SOCKET s[1]:
// return value is the number of bytes read, if zero, then EOF was encountered right away (0 bytes read)
z = read(s[1],readBuffer,sizeof(readBuffer));

if ( z < 0 ) 
{
	fprintf(stderr, "%s: read(%d,readBuffer,%d)\n", strerror(errno), s[1], sizeof(readBuffer));
	return 3; /* Failed read */
}

//Report message received by s[0]:
readBuffer[z] = 0; /*set NUL terminate so printf d.n. read past readBuffer[z-1] element*/
printf("Received message '%s' from socket s[1]\n", readBuffer);


system("netstat --unix -p");

// CLOSE THE SOCKETS:
// if cocket's File Descriptor is duplicated using dup() or dup2() function, 
// only the last outstanding close() can actually close down the socket.
//close(s[0]);
//close(s[1]);

//shutdown() d.n. release the socket's file unit bumber even when SHUT_RDWR is used; 
//Socket File Descriptors remain valid and in use until the fuction close() is called to release it!
shutdown(s[0],SHUT_RDWR);
shutdown(s[1],SHUT_RDWR);

system("sleep()");
system("netstat --unix -p");

puts("Done.");

return 0;
}
