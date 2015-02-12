
import java.io.*;
import java.net.*;

class ServeurSocket_UDP {

	//serveur : creation du ServerSocket
	try {
		sSocket = new ServerSocket(4444);
	}
	catch (IOException e) {
		System.out.println("Could not listen on port: 4444");
		System.exit(-1);
	}
		Socket cSocket = null;
	try {
		cSocket = serverSocket.accept();}
	catch (IOException e){
		System.out.println("Accept failed: 4444");
		System.exit(-1);
	}

	//After the server successfully establishes a connection with a client, it
	//communicates with the client using this code:
	PrintWriter out = new PrintWriter(cSocket.getOutputStream(), true);
	BufferedReader in = new BufferedReader(new InputStreamReader(cSocket.getInputStream()));
	String inputLine, outputLine;
	// initiate conversation with clientKnockKnockProtocol
	kkp = new KnockKnockProtocol();
	outputLine = kkp.processInput(null);
	out.println(outputLine);
	while ((inputLine = in.readLine()) != null) {
		outputLine = kkp.processInput(inputLine);
		out.println(outputLine);
		if (outputLine.equals("Bye."))
		break;
	}

	out.close();
	in.close();
	cSocket.close();
	sSocket.close();

}
