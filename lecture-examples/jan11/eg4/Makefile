CC      = mpicc
COPT    = -g -O3

LD      = $(CC)
LDFLAGS = $(COPT)

all: mpi_any.x

%.x: %.o mpi_any.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o *.x
