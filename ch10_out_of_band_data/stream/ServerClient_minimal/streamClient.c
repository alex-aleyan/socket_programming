#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include "func.h"



#ifdef DEBUG
#define BYTES
#endif

#define SERVER_SOCKET_IP "192.168.40.91"
#define SERVER_SOCKET_PORT "9099"


/*
	* 1. Looks up the daytime service for the tcp protocol.
	* 2. Connects to your PC's daytime server, using tcp.
	* 3. Reads the server date and time string that it sends back to your socket.
	* 4. Reports the data and time string to your terminal session.
	* 5. Closes the socket and exits back to the shell.
 */

int main(int argc, char **argv)
{

  // SOCKET OPTIONS STUFF:
  int z;
  int txBuf=0;
  int rxBuf=0;
  socklen_t optlen;
  
  int succ_or_fail;			//return value of connect() func; successful if 0, failed if -1
  char *srvr_addr = NULL;	//actual IP X.X.X.X of the server (in our case it will be loopback if 127.0.0.1) in Little Endian Format.
  char *srvr_port = NULL;	//actual PORT  of the server 
  
  /* struct sockaddr_in 
  * {
  *  sa_family_t sin_family;    // Address Family (Big Endian Order): byte1 and byte0
  *  uint16_t sin_port;         // Port Number (Big Endian Order): byte3 and byte02
  *  struct in_addr sin_addr;     // Internet address (Big Endian Order): byte7 through byte04 
  *	 unsigned char sin_succ_or_failero[8];  // Pad bytes 
  *	}; */
  struct sockaddr_in adr_srvr;	// AF_INET

  int client_sock_fd;			//The file descriptor to the socket created using socket() function: 
  int numOfCharsRcvd;
  
  /* struct servent 
   * {
   * 		char *s_name;						// official service name
   * 		char **s_aliases;		// alias list
   * 		int s_port;								// port number
   * 		char *s_proto;					// protocol to use
   * } */
  struct servent *sp; //service entry
  
  char dtbuf[128];	// Received Data from date/time service on the server
  
  // if cmd line args provided, the second arg provides the address, else use default address:
  if (argc >= 2) srvr_addr = argv[1];
  else srvr_addr = SERVER_SOCKET_IP;
  if (argc >= 3) srvr_port = argv[2];
  else srvr_port = SERVER_SOCKET_PORT;
  
  // Create a server socket address:
  // Clean up addr_srvr:
  memset(&adr_srvr, 0, sizeof(adr_srvr));
  // Domain (NETWORK; not UNIX):
  adr_srvr.sin_family = AF_INET;
  // IP Address (in Big Endian Order):
  adr_srvr.sin_addr.s_addr = inet_addr(srvr_addr);
  // Port (coverted to Big Endian order):
  adr_srvr.sin_port = htons(atoi(srvr_port)); 

  
  // Make sure IP address field is not empty:
  if ( adr_srvr.sin_addr.s_addr == INADDR_NONE ) bail("bad address.");
  
  //Create socket:
  client_sock_fd = socket(PF_INET, SOCK_STREAM,0);
  if (client_sock_fd == -1) bail("socket()");

  // SOCKET OPTIONS STUFF: GET SOCKET BUFFER OPTIONS
  optlen=sizeof(txBuf);
  z = getsockopt(client_sock_fd, SOL_SOCKET, SO_SNDBUF, &txBuf, &optlen);
  optlen=sizeof(rxBuf);
  z = getsockopt(client_sock_fd, SOL_SOCKET, SO_RCVBUF, &rxBuf, &optlen);
  printf("Socket s: %d\n", client_sock_fd);
  printf("Send buf: %d bytes\n", txBuf);
  printf("Receive buf: %d bytes\n", rxBuf);

  // SOCKET OPTIONS STUFF: SET SOCKET BUFFER OPTIONS:
  txBuf=5000;
  z = setsockopt(client_sock_fd, SOL_SOCKET, SO_SNDBUF, &txBuf, sizeof(txBuf));
  rxBuf=8192;
  z = setsockopt(client_sock_fd, SOL_SOCKET, SO_RCVBUF, &rxBuf, sizeof(rxBuf));
  printf("Socket s: %d\n", client_sock_fd);
  printf("Send buf: %d bytes\n", txBuf);
  printf("Receive buf: %d bytes\n", rxBuf);

  
  // Connect created socket to the daytime service
  succ_or_fail = connect(client_sock_fd, &adr_srvr, sizeof(adr_srvr));
  if (succ_or_fail == -1) bail("connect(2)");
  
  // Remember read() returns leng of string received
  numOfCharsRcvd=read(client_sock_fd, &dtbuf, sizeof(dtbuf)-1);
  if (numOfCharsRcvd==-1) bail("read(2)");
  
  // Terminate the buffer's string with the NULL
  dtbuf[numOfCharsRcvd] = 0;
  printf("Received Message: \"%s\"\n", dtbuf);
  system("sleep 3");
  
  // Close the connection
  close(client_sock_fd);
  
  putchar('\n');
  
  return 0;
}
