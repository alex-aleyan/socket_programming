#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <sys/types.h>
#include <sys/socket.h>
#include "func.h"

#ifdef DEBUG
#define BYTES
#endif


#define SERVER_SOCKET_IP "192.168.40.185"
#define SERVER_SOCKET_PORT 9090

int main (int argc, char **argv)
{
  char txDgramBuffer[512]="Hello World"; //DATA

  struct sockaddr_in rxAddress;
  memset(&rxAddress, 0, sizeof(rxAddress));
  rxAddress.sin_family = AF_INET; // Receiving Socket Family
  rxAddress.sin_addr.s_addr = inet_addr(SERVER_SOCKET_IP);// Receiving Socket IP Address
  if (argc >= 2) rxAddress.sin_addr.s_addr = inet_addr(argv[1]);
  rxAddress.sin_port = htons(SERVER_SOCKET_PORT); // Receiving Socket Port Number
  if (argc >= 3) rxAddress.sin_port = htons(atoi(argv[2]));
  
  //Establish a socket connection
  int txSocket = -1;
  txSocket = socket(AF_INET,SOCK_DGRAM,0); 

  int test = -1;
  //TX Socket, TX Data, TX Data Size, flags, RX Socket Info (DOMAIN, IP and PORT), size of RX Address Struct)
  test=sendto(txSocket, txDgramBuffer, strlen(txDgramBuffer),\
			  0, (struct sockaddr *) &rxAddress, sizeof(rxAddress) );
  if ( test < 0) printf("Failed to send\n");
  
  #ifdef BYTES
  printBytes( (unsigned char *) &rxAddress, 16);
  #endif
  
  return 0;
}
