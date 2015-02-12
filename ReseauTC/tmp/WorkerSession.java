package executionservice;
/**
 * Allows workers to obtain and execute tasks.
 * 
 */
public interface WorkerSession {
	/**
	 * Provides a task that is available for execution. Blocks if there is no available task.
	 * @return the task
	 * @throws InterruptedException 
	 */
	Task getTask() throws InterruptedException;
	/**
	 * Sets the result of executing the task. 
	 * @param result
	 */
	void setResult(long result);
	/**
	 * Closes this session.
	 */
	void close();
	

}
