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

  // Get TX Buffer Size 
  // sysctl net.core.wmem_default:
  // sysctl net.core.wmem_max:
  int getOptVal = 0;
  socklen_t getOptLen = sizeof(getOptVal);
  if ( getsockopt(txSocket, SOL_SOCKET, SO_SNDBUF, &getOptVal, &getOptLen) ) return -5;
  printf("Socket Tx buffer size: %d bytes\n",getOptVal);

  // Get RX Buffer Size 
  // sysctl net.core.rmem_default:
  // sysctl net.core.rmem_max:
  if ( getsockopt(txSocket, SOL_SOCKET, SO_RCVBUF, &getOptVal, &getOptLen) ) return -6;
  printf("Socket Rx buffer size: %d bytes\n",getOptVal);

  if ( getsockopt(txSocket, SOL_SOCKET, SO_KEEPALIVE, &getOptVal, &getOptLen) ) return -7;
  printf("Keep Alive: %d\n", getOptVal);

  if ( getsockopt(txSocket, SOL_SOCKET, SO_REUSEADDR, &getOptVal, &getOptLen) ) return -8;
  printf("Reuse address: %d\n", getOptVal);

  if ( getsockopt(txSocket, SOL_SOCKET, SO_TYPE, &getOptVal, &getOptLen) ) return -9;
  printf("Type: %d\n", getOptVal);

  // SOCKET TX BUFFER DEPTH:
  int setOptVal = 499712;
  socklen_t setOptLen = sizeof(setOptVal);
  if ( setsockopt(txSocket, SOL_SOCKET, SO_SNDBUF, &setOptVal, setOptLen) ) return -10;
  getOptVal=0;
  if ( getsockopt(txSocket, SOL_SOCKET, SO_SNDBUF, &getOptVal, &getOptLen) ) return -11;
  printf("Socket Tx buffer size: %d bytes\n",getOptVal);

  // SOCKET RX BUFFER DEPTH:
  setOptVal = 512;
  setOptLen = sizeof(setOptVal);
  if ( setsockopt(txSocket, SOL_SOCKET, SO_RCVBUF, &setOptVal, setOptLen) ) return -10;
  getOptVal=0;
  if ( getsockopt(txSocket, SOL_SOCKET, SO_RCVBUF, &getOptVal, &getOptLen) ) return -11;
  printf("Socket Rx buffer size: %d bytes\n",getOptVal);

  // SOCKET TYPE:
  getOptVal=0;
  if ( getsockopt(txSocket, SOL_SOCKET, SO_TYPE, &getOptVal, &getOptLen) ) return -11;
  printf("Socket Type: %d \n",getOptVal);
  printf("SOCK_STREAM=%d \n", SOCK_STREAM);
  printf("SOCK_DGRAM=%d \n", SOCK_DGRAM);

  // REUSE ADDRESS (zombie process):
  // Effective only if all existing sockets with the same addres:port_number have this option set!
  // If the above not true, the bind() will keep on returing an error.
  #define TRUE 1
  #define FALSE 0
  setOptVal = TRUE;
  if ( setsockopt(txSocket, SOL_SOCKET, SO_REUSEADDR, &setOptVal, sizeof(setOptVal) ) ) return -12;
  getOptVal=0;
  getOptLen=sizeof(getOptVal);
  if ( getsockopt(txSocket, SOL_SOCKET, SO_REUSEADDR, &getOptVal, &getOptLen ) ) return -12;
  printf("Socket Reuse Address: %d\n",getOptVal);

  // SO_LINGER:
  // Controls how the socket is shutdown the close() is called.
  // Applies to TCP sockets only.
  // By default, KERNEL allows the close() to return immediately to the caller, and any unsent TCP/IP is transmitted and delivered
  // if possible without guarantee and without knowing if the remaining data was actually delivered.
  // Enabling SO_LINGER on a socket forces the application to block the close() call until all the final data is delivered out, and
  // guarantees the two way acknowledgement of socket shutdown (if acknowledgement fails, a timeout occurs and an error is returned).
  // Another option allows to abort the communication immediately.
  // 
  // struct linger {
  //   int l_onoff;   //boolean
  //   int l_linger;  
  // };
  //
  // l_onoff = FALSE; causes l_linger to be ignored and default close() behavior is implied.
  // l_onoff = TRUE; l_linger = 0; close() aborts the connection immediately and any pending data is discarded.
  // l_onoff = TRUE; l_linger = <time in sec>; application blocks the close() call until the timeout specified in l_linger occurs.
  // 
  // Example:
  //  struct linger sock_linger;
  //  sock_linger.l_onoff = TRUE; // setting to FALSE gives default KERNEL behavior of close() function.
  //  sock_linger.l_linger = 15; // set to 0 if to abort communication immediately
  //  if ( setsockopt(<SOCKET FD>, SOL_SOCKET, SO_LINGER, &so_linger, sizeof so_linger) perror("setsockipt(2)");
  
  // SO_KEEPALIVE:
  // Enabled on a socket to detect disconnected idle connections by sending probe message to the remote end after 2 hrs of inactivity
  // Three possible responses to the keep-alive probe message:
  //   1. the peer response indicating that all is well.
  //   2. the peer response indicating it know nothing about the connection (peer has been rebooted perhaps).
  //   3. No response received. Kernel may attempt to send probe message a few more times but will give up in about 11 mins. The error ETIMEDOUT is returned with the next socket opeartion, or EHOSTUNREACH can be returned instead if the network is unreachable.
  //
  // Example:
  //  int so_keepalive;
  //  so_keepalive = TRUE;
  //  if ( setsocketopt(<SOCKET FD>, SOL_SOCKET, SO_KEEPALIVE, &so_keepalive, sizeof(so_keepalive)) ) perror("setsockopt(2)");
  
  // SO_BROADCAST:
  // Used to broadcast with UDP
  // can be misused and can easily flood the network.
  // By default, every socket created has broadcast feature disabled.
  //
  // Example:
  //
  //  int so_broadcast;
  //  if ( setsocketopt(<SOCKET FD>, SOL_SOCKET, SO_BROADCAST, &so_broadcast, sizeof(so_broadcast)) ) perror("setsockopt(2)");
  
  // SO_OOBINLINE:
  // used to send out of band traffic
  // 
  // Example:
  //  int so_oobinline;
  //  so_oobinline = TRUE;
  //  if ( setsocketopt(<SOCKET FD>, SOL_SOCKET, SO_OOBINLINE, &so_oobinline, sizeof(so_oobinline)) ) perror("setsockopt(2)");




  int test = -1;
  //TX Socket, TX Data, TX Data Size, flags, RX Socket Info (DOMAIN, IP and PORT), size of RX Address Struct)
  //test=sendto(txSocket, txDgramBuffer, strlen(txDgramBuffer),\
			  0, (struct sockaddr *) &rxAddress, sizeof(rxAddress) );
  //if ( test < 0) printf("Failed to send\n");
  
  #ifdef BYTES
  printBytes( (unsigned char *) &rxAddress, 16);
  #endif
  
  return 0;
}
