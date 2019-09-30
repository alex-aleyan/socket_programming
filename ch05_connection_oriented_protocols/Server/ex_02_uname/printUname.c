#include <netdb.h>

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <netinet/in.h>
#include <func.h>

#ifdef ALL
GETSERVENT
GETSERVBYNAME
GETSERVBYPORT
GETPROTOENT
GETPROTOBYNUMBER
#endif

int main()
{
		printUname();
}
