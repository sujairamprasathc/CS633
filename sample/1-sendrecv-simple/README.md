# Simple send and recv
This is a simple producer-consumer application which sends Hello World! from producer to consumer over MPI

## Build Instructions
```bash
make
```

## Execution Instructions
```bash
mpirun -n 2 ./sendrecv.out
```
or
```bash
mpiexec -n 2 -f hosts ./sendrecv.out
```
