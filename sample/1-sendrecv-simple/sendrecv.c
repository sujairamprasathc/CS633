#include <mpi.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
	char message[32] = { 0 };
	int myrank = 0, world_size = 0;
	MPI_Status status;

	// Initialize the MPI environment
	MPI_Init(NULL, NULL);

	// Get the number of applications launched
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);

	if (world_size < 2) {
		printf("This is a producer-consumer application\nNeed at least 2 processes to execute\n");
		return -1;
	}

	// Get the rank of the application
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

	if (myrank == 0) {	// Producer
		strcpy(message, "Hello World!");
		MPI_Send(message, strlen(message) + 1, MPI_CHAR, 1, 1, MPI_COMM_WORLD);
	}
	else if (myrank == 1) {	// Consumer - check rank to ensure processes with rank > 1 do not execute recv
		MPI_Recv(message, 30, MPI_CHAR, 0, 1, MPI_COMM_WORLD, &status);
		printf("Received: %s\n", message);
	}

	MPI_Finalize();
}
