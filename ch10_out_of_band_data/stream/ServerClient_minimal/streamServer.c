#include <netinet/in.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>

#include <arpa/inet.h>
#include <netdb.h>
#include "func.h"

#ifdef DEBUG
#define BYTES
#endif

#define SERVER_SOCKET_IP "127.0.0.1"
#define SERVER_SOCKET_PORT "9099"


/*
	* 1. Looks up the daytime service for the tcp protocol.
	* 2. Connects to your PC's daytime server, using tcp.
	* 3. Reads the server date and time string that it sends back to your socket.
	* 4. Reports the data and time string to your terminal session.
	* 5. Closes the socket and exits back to the shell.
 */

#include <inttypes.h>

int main(int argc, char **argv)
{
  
	int succ_or_fail;			
	char *srvr_addr = SERVER_SOCKET_IP;
	char *srvr_port = SERVER_SOCKET_PORT;
	struct sockaddr_in adr_srvr; // AF_INET server's address
	struct sockaddr_in adr_clnt; // AF_INET client's address
	int len_inet;		  // Length of IP address (4 bytes X.X.X.X)
	int listen_sock = -1; // Server's Listening Socket (catches a connection and passes it to a connection socket)
	int conn_sock = -1;	  // Server to Client Connect Socket
	char buffoon[128]="Hello There!";  // DateTime info
		
	if (argc >= 2)	srvr_addr = argv[1]; // cli provides address
	if (argc >= 3)	srvr_port = argv[2]; // if port provided as 2nd arg via cli

	listen_sock = socket(PF_INET, SOCK_STREAM, 0);
	if (listen_sock == -1) bail("bailing at socket() on line __LINE__");

	// Create a Listen Server Socket Address:
	memset(&adr_srvr, 0, sizeof(adr_srvr) );
    adr_srvr.sin_family = AF_INET;
	adr_srvr.sin_port = htons(atoi(srvr_port));

    printf("srvr_addr = %08x \n", *srvr_addr);
    printf("srvr_addr = %s \n", srvr_addr);
    printf("Compare the strings: %d \n", strcmp(srvr_addr, "*") );

    if ( strcmp(srvr_addr, "*") != 0 )
    {
	  adr_srvr.sin_addr.s_addr = inet_addr(srvr_addr); // use argv[1] as the address to bind to
	  printf("adr_srvr.sin_addr.s_addr = %08x\n", htonl(adr_srvr.sin_addr.s_addr));
	  if (adr_srvr.sin_addr.s_addr == INADDR_NONE ) bail("bad address."); 
    }
	else adr_srvr.sin_addr.s_addr = INADDR_ANY; // bind to any address/interface

	// Bind the Server Address:
	len_inet = sizeof(adr_srvr);
	if ( bind(listen_sock, (struct sockaddr * ) &adr_srvr, len_inet)  == -1 ) bail("bailing at bind() on line __LINE__");

	succ_or_fail = listen(listen_sock, 10);
	if ( succ_or_fail  == -1 ) bail("bailing at listen() on line __LINE__");

	//The Server Loop starts here:
	for (;;)
	{
	  len_inet = sizeof(adr_clnt);
	  // Accept Connection from the Client:
	  conn_sock = accept(listen_sock, (struct sockaddr *) &adr_clnt, &len_inet);
	  if ( conn_sock == -1) bail("bailing at accept() on line __LINE__");

	  // Reply to Client with the message:
	  succ_or_fail = write(conn_sock, buffoon, strlen(buffoon));
	  if ( succ_or_fail == -1) bail("bailing at write() on line __LINE__");

	  // Close the current connection socket
	  close(conn_sock);
	} 
}
