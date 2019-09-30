#include <netdb.h>

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <netinet/in.h>

#ifdef ALL
GETSERVENT
GETSERVBYNAME
GETSERVBYPORT
GETPROTOENT
GETPROTOBYNUMBER
#endif

int main()
{

		int x;
		struct servent *sp;
		/*
		struct servent {
		char *s_name;					// official service name 
		char **s_aliases; // alias list 
		int s_port;       // port number 
		char *s_proto;    // protocol to use
		*/

#ifdef GETSERVENT
for (;;) 
{
		errno = 0;
		if ( !(sp = getservent()) ) break;

		printf("%s:\n" "\tPort: %d\n" "\tProtocol: %s\n" "\tAliases: ", sp->s_name, ntohs(sp->s_port), sp->s_proto);

		for ( x = 0 ; sp->s_aliases[x] != NULL; x++ )
		{
				printf("%s ", sp->s_aliases[x]);
		}
				putchar('\n');
}
#endif


#ifdef GETSERVBYNAME
sp = getservbyname("echo", "tcp");
if ( !sp ) abort();
printf("%s:\n" "\tPort: %d\n" "\tProtocol: %s\n" "\tAliases: ", sp->s_name, ntohs(sp->s_port), sp->s_proto);
putchar('\n');
#endif


#ifdef GETSERVBYPORT
sp = getservbyport( htons(7), "tcp");
if ( !sp ) abort();
printf("%s:\n" "\tPort: %d\n" "\tProtocol: %s\n" "\tAliases: ", sp->s_name, ntohs(sp->s_port), sp->s_proto);
putchar('\n');
#endif

#ifdef GETPROTOENT
int y;
struct protoent *pp;

for (;;) 
{
		errno = 0;
		if ( !(pp = getprotoent()) ) break;

		printf("%s:\n" "\tProtocol: %d\n " "\tAliases: ", pp->p_name, pp->p_proto);

		for ( y = 0 ; pp->p_aliases[y] != NULL; y++ )
		{
		printf("%s ", pp->p_aliases[y]);
		}

putchar('\n');
}
#endif


#ifdef GETPROTOBYNUMBER
int z;
struct protoent *pn;

errno = 0;
if ( !(pn = getprotobynumber(6)) ) return 0;

printf("%s:\n" "\tProtocol: %d\n " "\tAliases: ", pn->p_name, pn->p_proto);

for ( z = 0 ; pn->p_aliases[z] != NULL; z++ )
{
		printf("%s ", pn->p_aliases[z]);
}
putchar('\n');
#endif


if ( errno != 0 && errno != ENOENT ) fprintf(stderr, "%s: getservent(3) %d\n", strerror(errno),errno);

return 0;

}

