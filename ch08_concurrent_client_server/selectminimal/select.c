#include <sys/types.h>
#include <sys/select.h>

#include <unistd.h>

#include <stdbool.h>

static inline int max(int lhs, int rhs) {
    if(lhs > rhs) return lhs;
    else return rhs; }

void copy(int from, int to) {

  char buffer[10];
  int readp = 0;
  int writep = 0;
  bool eof = false;

  for(;;) {
    fd_set readfds, writefds;
    FD_ZERO(&readfds);
    FD_ZERO(&writefds);
    
    int ravail, wavail;
  
    if(readp < writep) {
       ravail = writep - readp - 1;
       wavail = sizeof buffer - writep; }
    else {
       ravail = sizeof buffer - readp;
       wavail = readp - writep; }
    
    if(!eof && ravail) FD_SET(from, &readfds);
  
    if(wavail) FD_SET(to, &writefds);
    else if(eof) break;
  
    int rc = select(max(from,to)+1, &readfds, &writefds, NULL, NULL);
  
    if(rc == -1) break;
  
    if(FD_ISSET(from, &readfds)) {
       ssize_t nread = read(from, &buffer[readp], ravail);
       if(nread < 1) eof = true;
       readp = readp + nread;	 }
  
    if(FD_ISSET(to, &writefds)) {
       ssize_t nwritten = write(to, &buffer[writep], wavail);
       if(nwritten < 1) break;
       writep = writep + nwritten; }
  
    if(readp == sizeof buffer && writep != 0) readp = 0;
  
    if(writep == sizeof buffer) writep = 0;

  }
}
