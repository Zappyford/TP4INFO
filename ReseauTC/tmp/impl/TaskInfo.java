package executionservice.impl;

import executionservice.Task;

public class TaskInfo {
	
	final private Task task;
	private boolean available = true;
	private long result;
	private boolean completed = false;
	
	public TaskInfo(Task task) {
		this.task=task;
	}

	public synchronized Task getTask() {
		return this.task;
	}
	
	public synchronized boolean getAvailable() {
		return this.available;
	}
	public synchronized void setAvailable(boolean available) {
		this.available=available;
	}
	
	public synchronized void setResult(long result) {
		this.result=result;
		this.completed=true;
		notifyAll();
	}
	
	public synchronized long getResult() throws InterruptedException {
		while (!completed) wait();
		return result;
	}

}
