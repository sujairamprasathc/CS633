
#include <stdio.h>
#include <string.h>
#include "mpi.h"

#define BUFFER 1024 //131072

int main( int argc, char *argv[])
{
  int arr[BUFFER] = {0};
  int myrank, size;
  MPI_Status status;
  double start_time;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank( MPI_COMM_WORLD, &myrank );
  MPI_Comm_size( MPI_COMM_WORLD, &size );

  start_time = MPI_Wtime ();
  if (myrank != 1) 
  {
    MPI_Send(arr, BUFFER, MPI_INT, 1, 99, MPI_COMM_WORLD);
  }
  else if (myrank == 1) 
  {
    int count, recvarr[size][BUFFER];
    for (int i=0; i<size; i++)
    {
      if (i == myrank) continue;
      MPI_Recv(recvarr[i], BUFFER, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
      printf("Rank %d of %d received from rank %d\n", myrank, size, status.MPI_SOURCE);
    }
  }
  printf ("Rank %d: time=%lf\n", myrank, MPI_Wtime () - start_time);

  MPI_Finalize();
  return 0;
}
