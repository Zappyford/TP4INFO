/**
 * 
 */
package executionservice.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import executionservice.ExecutionService;
import executionservice.Task;
import executionservice.WorkerRegistration;
import executionservice.WorkerSession;

public class Client {

	static final int NUMTASKS = 10;
	static final int NUMWORKERS = 4;

	static private List<Integer> ids = new ArrayList<Integer>();

	public static void main(String[] args) {
		ExecutionServiceImpl es = new ExecutionServiceImpl();
		WorkerRegistration wr = (WorkerRegistration) es;
		// Creates a set of workers 
		for (int i = 0; i < NUMWORKERS; i++) {
			new Worker(wr, "wrk" + i).start();
		}

		// Starts timing.
		long time = System.currentTimeMillis();

		// Submits a set of tasks; each task calculates a different Fibonacci number
		for (int i = 0; i < NUMTASKS; i++) {
			int id = es.submitTask(new FibTask(27 + i));
			ids.add(id);
		}

		// Gets all the task results, waiting if necessary
		for (Integer i : ids) {
			long res = 0;
			try {
				res = es.getResult(i);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		// Stops timing.
		time = System.currentTimeMillis() - time;
		System.out.println("Time :" + time + " ms");
	}

}
