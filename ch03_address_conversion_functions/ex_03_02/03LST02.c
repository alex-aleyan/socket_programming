/* inetaddr.c:
	* *
	* * Example using inet_addr(3):
	* */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

/*
	* * This function reports the error and
	* * exits back to the shell:
	* */
static void bail(const char *on_what) {
				fputs(on_what,stderr);
				fputc('\n',stderr);
exit(1);
}

int main(int argc,char **argv) {
	int z;
	struct sockaddr_in adr_inet;			/* AF_INET */
	int len_inet;																		/* length */
	int sck_inet;																		/* Socket */
	
	/* Create a Socket */
	sck_inet = socket(AF_INET,SOCK_STREAM,0);
	
	if ( sck_inet == -1 )	bail("socket()");
	
	/* Establish address */
	memset(&adr_inet,0,sizeof adr_inet);
	
	adr_inet.sin_family = AF_INET;
	adr_inet.sin_port = htons(9000);
	
//	printf("inet_addr(\"127.0.0.5\"): %04x \n", inet_addr("127.0.0.5"));
	adr_inet.sin_addr.s_addr =	inet_addr("127.0.0.5");
	//adr_inet.sin_addr.s_addr =	inet_addr("255.255.255.255"); // broadcast address which does not work with inet_addr(); use inet_aton() instead

	printf("inet_addr(\"127.0.0.5\"): %04x \n", adr_inet.sin_addr.s_addr);
	
	if ( adr_inet.sin_addr.s_addr == INADDR_NONE )
	{		
				printf("The INADDR_NONE macro is %04x\n", INADDR_NONE);
				printf("inet_addr(\"127.0.0.5\") returned: %04x \n", adr_inet.sin_addr.s_addr);
				bail("bad address.");
	}

	len_inet = sizeof(adr_inet);
	
	/* Bind it to the socket */
	z = bind(sck_inet,	(struct sockaddr *)&adr_inet,	len_inet);
	
	if ( z == -1 )	bail("bind()");
	
	/* Display our socket address */
	system("netstat -pa --tcp | grep 03LST02");
	system("lsof -i tcp | grep 03LST02");
	//sleep(2);
return 0;
}
