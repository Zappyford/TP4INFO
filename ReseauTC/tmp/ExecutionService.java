/**
 * 
 */
package executionservice;
/**
 * Manages task submission. 
 * 
 */
public interface ExecutionService {
	/**
	 * Submits a task and returns a task identifier
	 * 
	 * @return identifier of the created task
	 */
	int submitTask(Task task);
	
	/**
	 * Returns the result of executing the identified task. Blocks if the result is not available.
	 * 
	 * @param taskid task identifier
	 * @throws InterruptedException 
	 */
	long getResult(int taskid) throws InterruptedException;
	
}
