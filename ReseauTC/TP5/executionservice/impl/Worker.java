package executionservice.impl;

import executionservice.Task;
import executionservice.WorkerRegistration;
import executionservice.WorkerSession;

public class Worker extends Thread {
	final WorkerRegistration wr;
	final String name;

	public Worker(WorkerRegistration wr, String name) {
		this.wr = wr;
		this.name = name;
	}

	public void run() {
		WorkerSession session = wr.register(name);

		// The worker continuously gets and executes tasks
		for (;;) {
			Task t = null;
			try {
				t = session.getTask();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			long res = t.execute();
			session.setResult(res);
			System.out.println("[Worker: " + name + "] sent result=" + res);
		}
		// session.close();
	}
}
