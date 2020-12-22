
#include <stdio.h>
#include <string.h>
#include "mpi.h"

int main( int argc, char *argv[])
{
  int arr[20] = {0};
  int myrank, size;
  MPI_Status status;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank( MPI_COMM_WORLD, &myrank );
  MPI_Comm_size( MPI_COMM_WORLD, &size );

  if (myrank == 0)    /* code for process zero */
  {
    MPI_Send(arr, 20, MPI_INT, 1, 99, MPI_COMM_WORLD);
  }
  else if (myrank == 1)  /* code for process one */
  {
    int count, recvarr[20];
    MPI_Recv(recvarr, 20, MPI_INT, 0, 99, MPI_COMM_WORLD, &status);
    MPI_Get_count (&status, MPI_INT, &count);
    printf("Rank %d of %d received %d elements\n", myrank, size, count);
  }

  MPI_Finalize();
  return 0;
}
