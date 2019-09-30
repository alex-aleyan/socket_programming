/* Receiver/client multicast Datagram example. */
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>


#define LOCAL_SOCKET_IP "192.168.40.185"
#define GROUP_IP "226.1.1.1"
#define GROUP_PORT 4321

#define MSG_BUFF_SIZE 32


int main(int argc, char *argv[])
{
  struct sockaddr_in localSock;
  struct ip_mreq mcastGroup;
  int localRxSock;

  /* Create a datagram socket on which to receive. */
  localRxSock = socket(AF_INET, SOCK_DGRAM, 0);
  if(localRxSock < 0) {	perror("Opening datagram socket error"); exit(1); }
  else  printf("Opening datagram socket....OK.\n");

  /* Enable SO_REUSEADDR to allow multiple instances of this */
  /* application to receive copies of the multicast datagrams. */
  int reuse = 1;
  if(setsockopt(localRxSock, SOL_SOCKET, SO_REUSEADDR, (char *)&reuse, sizeof(reuse)) < 0) {
	perror("Setting SO_REUSEADDR error"); close(localRxSock); exit(1);  }
  else  printf("Setting SO_REUSEADDR...OK.\n");

  /* Bind to the proper port number with the IP address */
  /* specified as INADDR_ANY. */
  memset((char *) &localSock, 0, sizeof(localSock));
  localSock.sin_family = AF_INET;
  localSock.sin_port = htons(GROUP_PORT);
  localSock.sin_addr.s_addr = INADDR_ANY;

  if(bind(localRxSock, (struct sockaddr*)&localSock, sizeof(localSock)))  {
	perror("Binding datagram socket error"); close(localRxSock); exit(1); }
  else printf("Binding datagram socket...OK.\n");

  /* Join the multicast mcastGroup 226.1.1.1 on the local 203.106.93.94 */
  /* interface. Note that this IP_ADD_MEMBERSHIP option must be */
  /* called for each local interface over which the multicast */
  /* datagrams are to be received. */
  mcastGroup.imr_multiaddr.s_addr = inet_addr(GROUP_IP);
  mcastGroup.imr_interface.s_addr = inet_addr(LOCAL_SOCKET_IP);
  if (argc >= 2)  mcastGroup.imr_interface.s_addr = inet_addr(argv[1]);

  if(setsockopt(localRxSock, IPPROTO_IP, IP_ADD_MEMBERSHIP, (char *)&mcastGroup, sizeof(mcastGroup)) < 0) {
	perror("Adding multicast mcastGroup error");	close(localRxSock); exit(1);  }
  else	printf("Adding multicast mcastGroup...OK.\n");

  // Create soft buffer where the received message is placed to and read by the application from:
  char recDataBuf[MSG_BUFF_SIZE];
  int recvdBytes = 0;

  struct sockaddr_in txAddress; // AF_INET
  int txSockLen;
  txSockLen = sizeof(txAddress);

  while(1)
  {
	// Read the multicast message from the socket:
    if( (recvdBytes = recvfrom(localRxSock, recDataBuf, sizeof(recDataBuf), 0, (struct sockaddr *) &txAddress, &txSockLen)) <= 0) {
  	  perror("Reading datagram message error"); close(localRxSock); exit(1); }
    else {
	  recDataBuf[recvdBytes] = 0;// Null terminate the string
	  printf("Reading datagram message...OK.\nThe message from multicast server %s:%u is: \"%s\"\n\n", \
			 inet_ntoa(txAddress.sin_addr), (unsigned) ntohs(txAddress.sin_port), recDataBuf); }
  }

  return 0;
}
