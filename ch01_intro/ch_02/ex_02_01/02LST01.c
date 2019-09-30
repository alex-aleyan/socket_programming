 /* af_unix.c:
	* *
	* * AF_UNIX Socket Example:
	* */
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
 #include <sys/un.h>

 /*
	* * This function reports the error and
	* * exits back to the shell:
	* */
static void bail(const char *on_what) 
{
		perror(on_what);
		exit(1);
}


int main(int argc,char **argv,char **envp) 
{

int z; /* Status return code */
int sck_unix; /* Socket */
struct sockaddr_un adr_unix;/* AF_UNIX */
int len_unix; /* length */
const char pth_unix[]="/tmp/my_sock";

/*
* Create a AF_UNIX (aka AF_LOCAL) socket:
* socket() returns the File Descriptor so sck_unix holds the File Descriptor for the created socket.
* */
sck_unix = socket(AF_UNIX,SOCK_STREAM,0);
printf("File Descriptr sck_unix: %d\n", sck_unix);
// check to make sure the socket was created
if ( sck_unix == -1 )
{
		printf("bailing socket\n");
		bail("socket()");
}

/*
 * Since AF_UNIX address results in a 
 * file system object being created,
 * the object must be removed when
 * it's no longer required.
* * Here we remove the pathname for the
* * socket, in case it existed from a
* * prior run. Ignore errors (it might
* * not exist).
* */
unlink(pth_unix);

/*
* * Form an AF_UNIX Address:
* */
memset(&adr_unix,0,sizeof(adr_unix));

adr_unix.sun_family = AF_UNIX;
printf("adr_unix.sun_family: %d\n", AF_UNIX);

printf("path_unix[0-%d]: %s\n",(sizeof(pth_unix)-2), pth_unix);
printf("pth_unix[12]: %d\n", pth_unix[12]);
printf("sizeof(path_unix): %d\n", sizeof(pth_unix));
//copy data from "pth_unix" to "adr_unix.sun_path":
strncpy(adr_unix.sun_path, pth_unix, sizeof((pth_unix)));

// put a terminating null so SUN_LEN() can be used:
adr_unix.sun_path[(sizeof(adr_unix.sun_path))] = 0;
printf("adr_unix.sun_path: %s\n", &(adr_unix.sun_path));
printf("adr_unix.sun_family: %02x\n", adr_unix.sun_family);

len_unix = SUN_LEN(&adr_unix);
printf("len_unix: %d\n", len_unix);

// Now bind the address to the socket:
z = bind(sck_unix,(struct sockaddr *) &adr_unix,len_unix);
// make sure it bound:
if ( z == -1 )
{
		printf("bailing bind() 2");
		bail("bind()");
}

/*
* * Display all of our bound sockets:
* */
system("netstat -pa --unix 2>/dev/null| "
"sed -n '/^Active UNIX/,/^Proto/p;"
"/af_unix/p'");
system("netstat --unix -p | grep my_sock");
system("ls -la /tmp/my_sock");

/*
* * Close and unlink our socket path:
* */
close(sck_unix);
unlink(pth_unix);
unlink("/tmp/mys");

return 0;
}

