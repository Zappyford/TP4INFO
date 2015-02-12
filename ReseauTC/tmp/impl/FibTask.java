package executionservice.impl;

import executionservice.Task;

class FibTask implements Task {
	private long n;

	FibTask(long n) {
		this.n = n;
	}

	@Override
	public long execute() {
		return fib(n);
	}

	public static long fib(long n) {
		if (n <= 1)
			return n;
		else
			return fib(n - 1) + fib(n - 2);
	}

}