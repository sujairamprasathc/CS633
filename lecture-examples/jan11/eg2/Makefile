CC      = mpicc
COPT    = -g -O3

LD      = $(CC)
LDFLAGS = $(COPT)

all: sendrecv_procname.x

%.x: %.o sendrecv_procname.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o *.x
