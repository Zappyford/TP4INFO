package executionservice;
/**
 * 
 * Represents a computation that returns a long.
 * 
 */
public interface Task {
	/**
	 * Executes computation.
	 *  
	 * @return the result 
	 */
	long execute();
}
