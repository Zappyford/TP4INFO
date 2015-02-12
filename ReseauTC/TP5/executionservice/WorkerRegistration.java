package executionservice;
/**
 * 
 * Manages worker registration.
 *
 */
public interface WorkerRegistration {
	/**
	 * Registers a worker with given name and returns a session object to be used by the worker. 
	 * 
	 * @param wname
	 * @return session object
	 */
WorkerSession register(String wname);
}
