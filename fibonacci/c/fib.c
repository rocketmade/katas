//to compile: gcc -o fib.c
//then ./fib 10
//

#include <stdio.h> //needed for printf and sscanf
#include <stdlib.h> //needed for malloc and free

int fib(int n);
int goodFib(int n);

int main(int argc, char *argv[])
{
	int value = 0;
	if (argc == 2)
	{
		sscanf(argv[1],"%i",&value);
		printf("Fib %i = %i\n",value, fib(value));
		printf("Good Fib %i = %i\n",value, goodFib(value));
	}
	else
	{
		printf("Useage: fib x\n");
	}
}

//Fib is the naive exponential recursive solution
int fib(int n)
{
	if (n == 0)
		return 0;
	if (n == 1)
		return 1;
	return fib(n-1) + fib(n-2);
}

//goodFib uses memoization to achieve a runtime of n
int goodFib(int n)
{
	if (n == 0)
	{
		return 0;
	}

	int *memo = (int *)malloc((n+1)*sizeof(int));

	//we can acomplish the same thing in c++ with the new operator
	//int *memo = new int[n+1];

	memo[0] = 0; memo[1] = 1;

	for (int i = 2; i <= n; ++i)
	{
		memo[i] = memo[i-1] + memo[i-2];
	}

	free(memo);

	//if using c++ we need to use the delete[] operator
	//delete[] memo;

	return memo[n];
}
