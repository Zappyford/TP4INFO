package executionservice.impl;

import java.util.Random;

import executionservice.Task;

class PiTask implements Task {

	private long n;
	private long seed;

	public PiTask(long l, long seed) {
		this.n = l;
		this.seed = seed;
	}

	public long execute() {

		Random prng = new Random(seed);

		// Generate n random points in the unit square and count how many are
		// in the unit circle

		// INSERT CODE HERE

	}

}