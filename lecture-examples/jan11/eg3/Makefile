CC      = mpicc
COPT    = -g -O3

LD      = $(CC)
LDFLAGS = $(COPT) 

all: status.x

%.x: %.o status.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o *.x
