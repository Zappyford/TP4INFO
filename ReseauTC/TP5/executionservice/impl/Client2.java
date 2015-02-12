/**
 * 
 */
package executionservice.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import executionservice.ExecutionService;
import executionservice.Task;
import executionservice.WorkerRegistration;
import executionservice.WorkerSession;

/**
 * @author Nikos Parlavantzas
 * 
 */
public class Client2 {
	static final int NUMTASKS=10;
	static final int NUMWORKERS=10;
	static private List<Integer> ids =new ArrayList<Integer>();

	public static void main (String[] args) {
		ExecutionServiceImpl es = new ExecutionServiceImpl();
		WorkerRegistration wr=(WorkerRegistration)es;
		for (int i=0; i<NUMWORKERS;i++) {
			new Worker(wr,"worker"+i).start();
		}
		
		// Start timing.
		long time = System.currentTimeMillis();
		long totalPoints=10000000 ;
		long totalCount=0;

		for (int i=0; i<NUMTASKS;i++) {
			int id=es.submitTask(new PiTask(totalPoints / NUMTASKS,i));
			ids.add(id);
		}
		for (Integer i: ids) {
			long res = 0;
			try {
				res = es.getResult(i);
				totalCount+=res;
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			// System.out.println("Result "+i+" is :"+res);
		}

		// Print approximate value of pi.
        System.out.println ("pi = " + 4.0 * totalCount / totalPoints);

		// Stop timing.
        time = System.currentTimeMillis()-time;
        System.out.println (time + " msec");
        }

	
}





