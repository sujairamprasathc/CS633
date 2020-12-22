CC      = mpicc
COPT    = -g -O3

LD      = $(CC)
LDFLAGS = $(COPT)

all: bigsend.x

%.x: %.o bigsend.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o *.x
