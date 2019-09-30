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
#include "func.h"

#ifdef DEBUG
#define BYTES
#endif

#define SERVER_SOCKET_IP "192.168.40.185"
#define SERVER_SOCKET_PORT 9090


//static void bail(const char *on_what)
//{
//		fputs(strerror(errno), stderr);
//		fputs(": ",stderr);
//		fputs(on_what,stderr);
//		fputc('\n',stderr);
//		exit(1);
//}



int main(int argc, char **argv)
{
  int testToBail;
  struct sockaddr_in rxAddress; // AF_INET
  struct sockaddr_in txAddress; // AF_INET
  int rxSocket;
  char receiveDgramBuffer[512];	// Receive Buffer
  
  rxSocket = socket(AF_INET,SOCK_DGRAM,0);
  if (rxSocket == -1) bail("Failed to create a socket; see line: rxSocket=socket(AF_INET,SOCKET_DGRAM,0);");
  
  memset(&rxAddress, 0, sizeof(rxAddress));
  rxAddress.sin_family = AF_INET;
  rxAddress.sin_addr.s_addr = inet_addr(SERVER_SOCKET_IP);
  if (rxAddress.sin_addr.s_addr == INADDR_NONE) bail("bad address.\n");
  rxAddress.sin_port = htons(9090);
  
  //inetSocketLength = sizeof(rxAddress);
  printf("FD returned by socket(): %d\n", rxSocket);
  
  testToBail = bind(rxSocket, (struct sockaddr *) &rxAddress, sizeof(rxAddress));
  if (testToBail == -1) bail("bind()");
  
  //system("netstat -neopa | grep Recv-Q ");
  //system("netstat -neopa | grep dgram ");
  
  int txSockLen;
  txSockLen = sizeof(txAddress);
  
  for(;;)
  {
    testToBail = recvfrom(rxSocket, receiveDgramBuffer, sizeof(receiveDgramBuffer),\
						  0, (struct sockaddr *) &txAddress, &txSockLen);
    if ( testToBail < 0) bail("recvfrom(2)");
    receiveDgramBuffer[testToBail] = 0; //NULL terminate the received string
    printf("RECEIVED DGRAM: \"%s\"\n", receiveDgramBuffer);
    printf("RECEIVED FROM: %s:%u\n\n", inet_ntoa(txAddress.sin_addr), (unsigned) ntohs(txAddress.sin_port));
  #ifdef BYTES
    printBytes( (unsigned char *) &txAddress, 16);
  #endif
  }
  
   //testToBail = sendto(rxSocket, sendDgramBuffer, strlen(sendDgramBuffer), 0, (struct sockaddr *) &txAddress, inetSocketLength );
  
  shutdown(rxSocket, SHUT_RDWR);
  
  return 0;
}
  
  
