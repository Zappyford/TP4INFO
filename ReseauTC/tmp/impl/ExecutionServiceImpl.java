package executionservice.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import executionservice.ExecutionService;
import executionservice.Task;
import executionservice.WorkerRegistration;
import executionservice.WorkerSession;

public class ExecutionServiceImpl implements ExecutionService,
		WorkerRegistration {

	private int nextId = 0;
	private Map<Integer, TaskInfo> tasks = new HashMap<Integer, TaskInfo>();
	private int availableTasks = 0;

	@Override
	public synchronized int submitTask(Task task) {
		TaskInfo taskInfo = new TaskInfo(task);
		tasks.put(nextId, taskInfo);
		availableTasks++;
		notifyAll();
		return nextId++;
	}

	@Override
	public long getResult(int taskid) throws InterruptedException {

		TaskInfo taskInfo;
		synchronized (this) {
			taskInfo = tasks.get(taskid);
		}
		long res=taskInfo.getResult();
		synchronized (this) {
			tasks.remove(taskid);
		}
		return res;
	}

	@Override
	public WorkerSession register(String wname) {
		WorkerSession ws = new WorkerSessionImpl(wname, this);
		return ws;
	}

	synchronized TaskInfo getAvailableTaskInfo() throws InterruptedException {

		while (availableTasks == 0)
			wait();
		
		for (TaskInfo ti : tasks.values()) {
			if (ti.getAvailable()) {
				ti.setAvailable(false);
				availableTasks--;
				return ti;
			}
		}
		assert false;
		return null;
	}

}
