#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>


#define LOCAL_SOCKET_IP "192.168.40.180"
#define GROUP_IP "226.1.1.1"
#define GROUP_PORT 4321

#define BUFFER_SIZE 32


int main (int argc, char *argv[ ])
{
  struct in_addr localInterface;
  char sendDataBuf[BUFFER_SIZE] = "Hello the Multicast World!";

  /* Create a datagram socket on which to send. */
  int localTxSock;
  localTxSock = socket(AF_INET, SOCK_DGRAM, 0);
  if(localTxSock < 0){ perror("Opening datagram socket error"); exit(1); }
  else printf("Opening the datagram socket...OK.\n");

  /* Initialize the group sockaddr structure with a */
  /* group address of 225.1.1.1 and port 5555. */
  struct sockaddr_in groupAddr;
  memset((char *) &groupAddr, 0, sizeof(groupAddr));
  groupAddr.sin_family = AF_INET;
  groupAddr.sin_addr.s_addr = inet_addr(GROUP_IP);
  groupAddr.sin_port = htons(GROUP_PORT);


  /* Set local interface for outbound multicast datagrams. */
  /* The IP address specified must be associated with a local, */
  /* multicast capable interface. */
  localInterface.s_addr = inet_addr(LOCAL_SOCKET_IP);
  if( setsockopt(localTxSock, IPPROTO_IP, IP_MULTICAST_IF, (char *)&localInterface, sizeof(localInterface)) < 0) {
    perror("Setting local interface error"); exit(1); }
  else printf("Setting the local interface...OK\n");

  // Send a message to the multicast group specified by the*/
  if( sendto(localTxSock, sendDataBuf, strlen(sendDataBuf), 0, (struct sockaddr*)&groupAddr, sizeof(groupAddr)) < 0) {
    perror("Sending datagram message error"); }
  else printf("Sending datagram message...OK\n%s\n",sendDataBuf);

  return 0;
}
