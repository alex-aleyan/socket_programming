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

#define READFILE "data.bin"

#ifdef DEBUG
#define SHOW_FD
#define SHOW_DATA
#endif


int main (int argc, char *argv[ ])
{


  /* READ THE BINARY DATA FROM A FILE: */
  FILE *fd = NULL;
  /* Read the data into dataArray[]. */
  if ((fd=fopen(READFILE,"rb"))==NULL) {fprintf(stderr, "Unable to open file %s", READFILE); return 1;} 
  fseek(fd, 0, SEEK_END); // go to the end of file
  unsigned long fileLen=ftell(fd); //determine the length of file in bytes

#ifdef SHOW_FD
  printf("fileLen (bytes): %d\n", fileLen);
#endif
  
  fseek(fd, 0, SEEK_SET);
  unsigned char sendDataBuf[fileLen];
  // fread(buffer=to read to, 32=number of reads, 1=each read gets 1 byte from file, FileDescriptor=to read from):
  fread(sendDataBuf, fileLen , 1, fd);

#ifdef SHOW_DATA
  unsigned char * charPtr=(unsigned char*) sendDataBuf;
  printf("The data read from %s: ", READFILE);
  int i; for(i=0; i<fileLen; i++) printf("0x%02x ", *(charPtr+i) );
  printf("\n");
#endif
  
  fclose(fd);



  /* SEND THE READ DATA VIA MULTICAST: */

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
#ifdef SHOW_DATA
  printf("Multicast Address (big endian): %08x\n", groupAddr.sin_addr.s_addr);
  printf("Multicast Address: %s\n", inet_ntoa(groupAddr.sin_addr));
  printf("Multicast Port: %08x\n", ntohs(groupAddr.sin_port));
  printf("Multicast Port: %d \n", ntohs(groupAddr.sin_port));
#endif

  /* Set local interface for outbound multicast datagrams. */
  /* The IP address specified must be associated with a local, */
  /* multicast capable interface. */
  struct in_addr localInterface;
  localInterface.s_addr = inet_addr(LOCAL_SOCKET_IP);
  if (argc >= 2)  localInterface.s_addr = inet_addr(argv[1]);
#ifdef SHOW_DATA
  printf("Tx NIC (big endian): %08x\n", localInterface.s_addr);
  printf("Tx NIC: %s\n", inet_ntoa(localInterface));
#endif
  if( setsockopt(localTxSock, IPPROTO_IP, IP_MULTICAST_IF, (char *)&localInterface, sizeof(localInterface)) < 0) {
    perror("Setting local interface error"); exit(1); }
  else printf("Setting the local interface...OK\n");

  // Send a message to the multicast group specified by the*/
  if( sendto(localTxSock, sendDataBuf, fileLen, 0, (struct sockaddr*)&groupAddr, sizeof(groupAddr)) < 0) {
    perror("Sending datagram message error"); }
  else printf("Sending datagram message...OK\n");

  return 0;
}
