/* af_inet.c:
	* *
	* * Establishing a Specific AF_INET
	* * Socket Address:
	* */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>

/*
	* * This function reports the error and
	* * exits back to the shell:
	* */
static void
bail(const char *on_what) {
perror(on_what);
exit(1);
}

void bytes(unsigned char * address,int num)
{
int n=num, i =0; 
unsigned char* byte_array = address;
printf("\|#\t\t\|\t\|hex\|\t\|char\t\|\t\|dec\t\|\n");
while (i < n)
{  

printf("\|byte[%d]: \t\|\t",i);
printf("\|%02X \|\t",(unsigned)byte_array[i]);
printf("\|%c \t\|\t",(unsigned)byte_array[i]);
printf("\|%d\t\|\n",(unsigned)byte_array[i]);
i++;
}   
}


int main(int argc,char **argv,char **envp) 
{

int z; /* Status return code */
int sck_inet; /* Socket */
struct sockaddr_in adr_inet;/* AF_INET */
int len_inet; /* length */
const unsigned char IPno[] = {
127, 0, 0, 23 /* Local loopback */
};

/* Create an IPv4 Internet Socket */
sck_inet = socket(AF_INET,SOCK_STREAM,0);

if ( sck_inet == -1 )
{
bail("socket()");
printf("FAILED:STUB1\n");
}

/* Create an AF_INET address */
memset(&adr_inet,0,sizeof adr_inet);

//adr_inet.sin_family = htons(AF_INET);
adr_inet.sin_family = AF_INET;
adr_inet.sin_port = htons(9000);
//adr_inet.sin_addr.s_addr= htonl(INADDR_LOOPBACK);
memcpy(&adr_inet.sin_addr.s_addr,IPno,4);
len_inet = sizeof(adr_inet);
bytes((unsigned char *)&adr_inet,len_inet);

/* Now bind the address to the socket */
z = bind(sck_inet,(struct sockaddr *)&adr_inet,len_inet);

if ( z == -1 )
{
bail("bind()");
printf("FAILED:STUB2\n");
}

/* Display all of our bound sockets */
system("netstat -pa --tcp 2>/dev/null | sed -n '1,/^Proto/p;/af_inet/p'");
system("netstat -pa --tcp | grep 02LST03");
system ("netstat -i");

close(sck_inet);
return 0;
}


