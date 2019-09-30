/* af_inet.c:
	* *
	* * Establishing a Specific AF_X25
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
#include <linux/x25.h>

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
int sck_x25; /* Socket */
struct sockaddr_x25 adr_x25;/* AF_X25 */
int len_x25; /* length */
const unsigned char x25_host[] = "79400900"; /* Local loopback */

/* Create an IPv4 Internet Socket */
sck_x25 = socket(AF_X25,SOCK_SEQPACKET,0);

if ( sck_x25 == -1 )
{
bail("socket()");
printf("FAILED:STUB1\n");
}

/* Create an AF_X25 address */
//memset(&adr_x25,0,sizeof(adr_x25));

//adr_x25.sx25_family = htons(AF_X25);
adr_x25.sx25_family = AF_X25;
strcpy(adr_x25.sx25_addr.x25_addr, (const char *) x25_host);
len_x25 = sizeof(adr_x25);
bytes((unsigned char *)&adr_x25,len_x25);

/* Now bind the address to the socket */
z = bind(sck_x25,(struct sockaddr *)&adr_x25,len_x25);

if ( z == -1 )
{
bail("bind()");
printf("FAILED:STUB2\n");
}

/* Display all of our bound sockets */
puts("X.25 SOCKETS:");
system("cat /proc/net/x25");

//close(sck_x25);
return 0;
}


