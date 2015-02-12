package executionservice.impl;

import executionservice.Task;
import executionservice.WorkerSession;

public class WorkerSessionImpl implements WorkerSession {
	private final ExecutionServiceImpl exe;
	private final String name;
	private TaskInfo info;
	private boolean closed=false;
	
	public WorkerSessionImpl(String name, ExecutionServiceImpl exe) {
	this.name=name;
	this.exe=exe;
	}

	@Override
	public void close() {
		this.closed=true;
	}

	@Override
	public Task getTask() throws InterruptedException {
		if (closed==true) throw new RuntimeException("worker session closed");
		this.info=exe.getAvailableTaskInfo();
		return info.getTask();
	}

	@Override
	public void setResult(long result) {
		if (closed==true) throw new RuntimeException("worker session closed");
		info.setResult(result);
	}

}
