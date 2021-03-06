#

CC=cc
CXX=c++
DEFS=
CFLAGS=-c -Wall -O2 -DPSC_READ_KEY=\"abcd1234\" -DPSC_WRITE_KEY=\"abcd5678\" -std=c++11 -pedantic $(DEFS)
CFLAGS+=-DHAVE_UNIX98

all: psc-local psc-remote

clean:
	rm -f *.o

psc-local: misc.o client.o pcwrap.o pty.o pty98.o
	$(CXX) misc.o pcwrap.o client.o pty.o pty98.o -o psc-local -lcrypto

psc-remote: misc.o server.o pty.o pty98.o pcwrap.o
	$(CXX) misc.o server.o pty.o pty98.o pcwrap.o -o psc-remote -lcrypto

pcwrap.o: pcwrap.cc
	$(CXX) $(CFLAGS) pcwrap.cc

client.o: client.cc
	$(CXX) $(CFLAGS) client.cc

server.o: server.cc
	$(CXX) $(CFLAGS) server.cc

misc.o: misc.cc
	$(CXX) $(CFLAGS) misc.cc

pty.o: pty.cc
	$(CXX) $(CFLAGS) pty.cc

pty98.o: pty98.cc
	$(CXX) $(CFLAGS) pty98.cc

#main.o: main.cc
#	$(CXX) $(CFLAGS) main.cc


