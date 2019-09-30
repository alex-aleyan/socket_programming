/* Listing 1.3
 * *
 * * Client/Server Example Using socketpair(2)
 * * and fork(2):
 * */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>




#ifndef SHUT_WR
#define SHUT_RD 0
#define SHUT_WR 1
#define SHUT_RDWR 2
#endif





int main(int argc,char **argv) 
{
	printf("Main: STUB1\n");
	  
	pid_t chpid;	/* Child PID */
	
	//CREATE A PAIR OF LOCAL SOCKETS:
	//z=0 if socketpair() successful, else -1
	// socketpair(int domain, int type, int protocol, int fds[2])
	
	//Now fork() into two processes:
	//1. Launch child process using fork() command
	//2. load the return value of fork() into chpid and compare it agains pid_t - 1
	printf("Main: STUB2\n");
	// Anything above is run by the Parent Process Only; Anything below is run by both Processes
	chpid = fork();
	printf("Main: STUB3\n");
	printf("Main: chpid: %d pid_t: %d ((pid_t)-1): %d\n", chpid, ((pid_t)+0), ((pid_t) - 1) );
	printf("Main: STUB4\n");


	if ( chpid == (pid_t)-1 ) {
	  //Failed to fork into two processes:
	  fprintf(stderr,"%s: fork(2)\n", strerror(errno)); exit(1); }

	// PARENT PROCESS:
	else if ( chpid != 0 )	{
		printf("\nParent Process: STUB5\n");
		int status;

		printf("Parent Process: Parent PID is %ld\n",(long)getppid());
		printf("Parent Process: Child PID is %ld\n",(long)getpid());
		printf("Parent Process: !!!chpid: %d\n\n", chpid);
		// Wait for the child process to exit. See text.
		waitpid(chpid,&status,0);  }

	// CHILD PROCESS:
	else if ( chpid == 0 ) {
		printf("\nChild Process: STUB6\n");
		printf("Child Process: Parent PID is %ld\n",(long)getppid());
		printf("Child Process: Child PID is %ld\n",(long)getpid());
		printf("Child Process: !!!chpid: %d\n", chpid); } 

	// None-sense?
	else printf("poop");


return 0;
}
