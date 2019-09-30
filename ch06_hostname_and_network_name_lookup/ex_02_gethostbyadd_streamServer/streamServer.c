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

#define SERVER_SOCKET_IP "127.0.0.1"
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
  
		int succ_or_fail;			
		char *srvr_addr = SERVER_SOCKET_IP;
		char *srvr_port = SERVER_SOCKET_PORT;
		struct sockaddr_in adr_srvr; // AF_INET server's address
		struct sockaddr_in adr_clnt; // AF_INET client's address
		int ipLength;					// Length of IP address (4 bytes X.X.X.X)
		int listen_sock;		// Server's Listening Socket
		int conn_sock;				// Server to Client Connect Socket
		int num_of_bytes; // Number of bytes sent from Server to Client
		time_t time_date; // Current time and date
		char dtbuf[128];		// DateTime info

		struct hostent *hostEntry_ptr; // host entry pointer

		FILE *logf;
		char fileName[80];
		char readMode[3]="r";
		char writeMode[3]="w";
		char appendMode[3]="a";

		strcpy(fileName, argv[0]);
    strcat(fileName,".log");

		if ( (logf = fopen( fileName, readMode )) == NULL ){	// if file does not exist
				printf("No file exists. Creating new file\n");
				(logf = fopen( fileName, appendMode)); //writeMode ));		// then we create the file

				if (logf == NULL){ // and if we fail to create the file, return a null pointer.
						fprintf(stderr,"Error occurred when IF, exiting");
						fclose(logf);
						return 0; } }
		else { // else file already exists, open it in append mode so we don't delete old log stuff
				printf("File already exists; the log data will be appended to data contained.\n");
				fclose(logf);
				(logf = fopen( fileName, appendMode ));//appendMode ));

				if (logf == NULL) {
						fprintf(stderr,"Error occurred when ELSE, exiting");
            fprintf(stderr,"%s: opneing %s for read. \n", strerror(errno), fileName);
						fclose(logf);
						return 0;} 
		}
		
		if (argc >= 2)	srvr_addr = argv[1];	// cli provides address
		if (argc >= 3)	srvr_port = argv[2]; // if port provided as 2nd arg via cli

  // 1. Create a Listening Socket:
		listen_sock = socket(PF_INET, SOCK_STREAM, 0);
		if (listen_sock == -1) bail("bailing at socket() on line __LINE__");

  // 2. Create a Listen Server Socket Address:
		memset(&adr_srvr, 0, sizeof(adr_srvr) );
  adr_srvr.sin_family = AF_INET;
		adr_srvr.sin_port = htons(atoi(srvr_port));
  if (strcmp(srvr_addr, "*") != 0){ //
				adr_srvr.sin_addr.s_addr = inet_addr(srvr_addr);
				if (adr_srvr.sin_addr.s_addr == INADDR_NONE ) bail("bad address."); }
		else	adr_srvr.sin_addr.s_addr = INADDR_ANY; // Wild Address; bind to any address

  // 3. Bind the Server Address to the socket:
		ipLength = sizeof(adr_srvr);
		succ_or_fail = bind(listen_sock, (struct sockaddr * ) &adr_srvr, ipLength);
		if ( succ_or_fail  == -1 ) bail("bailing at bind() on line __LINE__");

  // 4. Listen to the Clients:
		succ_or_fail = listen(listen_sock, 10);
		if ( succ_or_fail  == -1 ) bail("bailing at listen() on line __LINE__");

		//The Server Loop starts here:
		for (;;){
				ipLength = sizeof(adr_clnt);
//				printf("listen_sock: %d\n", listen_sock);
//				printBytes(&adr_clnt, 16);
//				printf("&ipLength: %d\n", ipLength);
				// 5. Accept incomming connection from the clients and create a Connection Socket per each Client Accept:
				conn_sock = accept(listen_sock, (struct sockaddr *) &adr_clnt, &ipLength);
				if ( conn_sock == -1) bail("bailing at accept() on line __LINE__");

				fprintf(logf, "Client %s:", inet_ntoa(adr_clnt.sin_addr));

				hostEntry_ptr = gethostbyaddr( (char *) &adr_clnt.sin_addr, sizeof(adr_clnt.sin_addr), adr_clnt.sin_family);
				if ( hostEntry_ptr == NULL)	fprintf(logf, "Error: %s\n", hstrerror(h_errno));
				else	fprintf(logf, " %s\n", (*hostEntry_ptr).h_name);
				//else	fprintf(stdout, " %s\n", (*hostEntry_ptr).h_name);
				printf(" %s\n", (*hostEntry_ptr).h_name);

				fflush(logf);

				//Generate a time stamp:
				time(&time_date);
				num_of_bytes = (int) strftime(dtbuf, sizeof(dtbuf),"%A %b %d %H:%M:%S %Y\n", localtime(&time_date));

				succ_or_fail = write(conn_sock, dtbuf, num_of_bytes);
				if ( succ_or_fail == -1) bail("bailing at write() on line __LINE__");

				close(conn_sock);
		} 
fclose(logf);
}
