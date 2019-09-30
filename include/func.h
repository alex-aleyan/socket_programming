#include <stdio.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include "string.h"

void bytes(unsigned char * address,int num);
void printBytes(unsigned char * address,int num);

// Prints the content of a buffer
// Requires the pointer to a buffer and the buffer's size
void bytes(unsigned char * address,int num)
{

int n=num, i=0; 
unsigned char* byte_array = address;

printf("\|byte: \|\t",i);
printf("\|HEX: \|\t");
printf("\|CHAR: \|\t");
printf("\|DEC:\n");

		while (i < n)
		{   
				printf("\|byte[%d]: \|\t",i);
				printf("\|%02X \|\t",(unsigned)byte_array[i]);
				printf("\|%c \|\t",(unsigned)byte_array[i]);
				printf("\|%d\n",(unsigned)byte_array[i]);
				i++;
		}   
}

void printBytes(unsigned char * address,int num)
{
  bytes(address, num);
}


void printAddressClass(struct sockaddr_in adr_inet)
{
	 char *netmask = malloc(1);
  unsigned char * msb;
	 char class;

  /*
  ** * Classify this address:
  ** *
  ** * 1. Get the Most Significant Byte
  ** * 2. Classify by that byte
  ** */

  msb = (unsigned char *) &(adr_inet.sin_addr.s_addr);
  printf("MSB: %02x\n", *msb);

  if ( (*msb & 0x80) == 0x00 ) {
    class = 'A';
    netmask = "255.0.0.0"; }
  else if ( (*msb & 0xC0) == 0x80 ) {
    class = 'B';
    netmask = "255.255.0.0";}
  else if ( (*msb & 0xE0) == 0xC0 ) {
    class = 'C';
    netmask = "255.255.255.0";}
  else if ( (*msb & 0xF0) == 0xE0 ) {
    class = 'D';
    netmask = "255.255.255.255";}
  else {
    class = 'E';
    netmask = "255.255.255.255";}

  printf("Address %02x %02x %02x %02x is class %c " "netmask %s\n", *msb, *(msb+1), *(msb+2), *(msb+3) , class, netmask);
  printf("Address %d %d %d %d is class %c " "netmask %s\n", *msb, *(msb+1), *(msb+2), *(msb+3) , class, netmask);

}


static void printSocketPS(char * argvZero)
{
		system("netstat -neopa | grep Recv-Q ");
		system("netstat -neopa | grep *argvZero ");
}


static void bail(const char *on_what)
{
  fputs(strerror(errno), stderr);
  fputs(": ",stderr);
  fputs(on_what,stderr);
  fputc('\n',stderr);
  exit(1);
}


//static void printServices(void)
//{
//
//		int x;
//		struct servent *sp;
//		/*
//		struct servent {
//		char *s_name;					// official service name 
//		char **s_aliases; // alias list 
//		int s_port;       // port number 
//		char *s_proto;    // protocol to use
//		*/
//
//
//for (;;) 
//{
//		errno = 0;
//		if ( !(sp = getservent()) ) break;
//
//		printf("%s:\n" "\tPort: %d\n" "\tProtocol: %s\n" "\tAliases: ", sp->s_name, ntohs(sp->s_port), sp->s_proto);
//
//		for ( x = 0 ; sp->s_aliases[x] != NULL; x++ )
//				printf("%s ", sp->s_aliases[x]);
//				putchar('\n');
//		}
//
//		if ( errno != 0 && errno != ENOENT ) fprintf(stderr, "%s: getservent(3) %d\n", strerror(errno),errno);
//
//}


// SEE CHAPTER 7
#include <sys/utsname.h>

int printUname(void) {
	int z;
	struct utsname u_name;
	
	z = uname(&u_name);
	
	if ( z == -1 ) {
		fprintf(stderr,"%s: uname(2)\n",
		strerror(errno));
		exit(1);}
	
	printf(" sysname[] = '%s';\n", u_name.sysname);
	printf(" nodename[] = '%s';\n",u_name.nodename);
	printf(" release[] = '%s';\n",	u_name.release);
	printf(" version[] = '%s';\n",	u_name.version);
	printf(" machine[] = '%s';\n",	u_name.machine);
	//printf("domainname[] = '%s';\n",	u_name.__domainname);
	
	return 0;
}


int printNames(void) {
		int succ_or_fail;
		char buff[32];

		succ_or_fail = gethostname(buff, sizeof(buff));
		printf("hostname = '%s'\n", buff);
		succ_or_fail = getdomainname(buff, sizeof(buff));
		printf("domainname = '%s'\n", buff);

		return 0;
}

#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>

int printHostByName(char *hostName){
		unsigned int x, x2, i;
		/* struct hostent {
			*   char *h_name;						 // official name of host 
		 *   char **h_aliases;			// alias list 
		 *   int h_addrtype;					// host address type 
		 *   int h_length;							// length of address 
		 *   char **h_addr_list; // list of pointers pointing to addresses in big endian
		 * };
		 * // for backward compatibility 
		 * #define h_addr h_addr_list[0] */
		struct hostent *hp;

		hp = gethostbyname(hostName);
		if ( !hp){
				fprintf(stderr, "%s: host '%s'\n", hstrerror(h_errno), hostName); 
		}

		printf("  Host: %s \n", hostName);
		printf("  Officially: \t%s\n", hp->h_name);
		fputs("  Aliases:\t", stdout);
		for (x2=0; hp->h_aliases[x2]; ++x2){
				if (x2){
						fputs(", ", stdout);
						fputs(hp->h_aliases[x2], stdout);
				}
		}

		fputc('\n', stdout);
		printf("  Type: \t\t%s\n", hp->h_addrtype == AF_INET ? "AF_INET" : "AF_INET6");

		if ( hp->h_addrtype == AF_INET ) {

//				for (i = 0; hp->h_addr_list[i] != NULL; i++){
				for (i = 0; ((*hp).h_addr_list + i) != NULL; i++){

//						printf("  IP Address: %s \n", inet_ntoa(*(struct in_addr*)(hp->h_addr_list[i])) );

						// (*hp).h_addr_list is an array of pointers where 
						// (*hp).h_addr_list points to the address of the first string containing an IP addres
						// ( (*hp).h_addr_list + 1 ) points to the address of the second string containing an IP addres
						// (* ( (*hp).h_addr_list + 1 ) ) returns the string the pointer above point to by deferencing the pointer!
						printf("  IP Address: %s \n", inet_ntoa( *((struct in_addr *) *((*hp).h_addr_list + i) ) ));
				}
				putchar('\n');
		}

		return 0;

}
