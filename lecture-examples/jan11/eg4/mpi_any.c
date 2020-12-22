
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

  if (myrank != 1) 
  {
    MPI_Send(arr, 20, MPI_INT, 1, 99, MPI_COMM_WORLD);
  }
  else if (myrank == 1) 
  {
    int count, recvarr[size][20];
    for (int i=0; i<size; i++)
    {
      if (i == myrank) continue;
      MPI_Recv(recvarr[i], 20, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
      printf("Rank %d of %d received from rank %d\n", myrank, size, status.MPI_SOURCE);
    }
  }

  MPI_Finalize();
  return 0;
}
