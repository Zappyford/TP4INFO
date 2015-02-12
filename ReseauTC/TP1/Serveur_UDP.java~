import java.io.*;
import java.net.*;

class Serveur_UDP {

	DatagramPacket Message;
	DatagramSocket socket;
	byte[] sendBuf = new byte[256];
	InetAddress Adresse_IP = null;
	String Hote;
	int Port = 0;
	Client_UDP c;

	//serveur : creation du ServerSocket

	public Comm_UDP_1 (int Un_Port, Client_UDP c, String Un_Hote )
    	{
	      this.Port  = Un_Port;
	      this.client = c;
	      this.hote  = Un_Hote;
    	}

      // Donner au thread un nom qui commence par UDP
      // ---- this.setName("UDP"+Thread.currentThread().getName()); 
             
      try 
	{
	  Adresse_IP = InetAddress.getByName(hote);
	} 
      catch (UnknownHostException e) 
	{
	  System.out.println("Erreur sur Adresse_IP");
	  System.exit (1);
        }
      
      // Ouvrir un socket UDP      
      try 
	{
	  Socket_UDP = new DatagramSocket(Port);
	} 
      catch  (IOException e) 
	{
	  System.out.println("Erreur sur DatagramSocket");
        }

	// Attendre la reponse emise par le serveur
	Message = new DatagramPacket(sendBuf, 256);
      try 
	{
	  Socket_UDP.receive(Message);
	} 
      catch  (IOException e) 
	{
	  System.out.println("Erreur Socket_UDP.receive :");
	  e.printStackTrace();
        }
	System.out.println("Message reçu");

      // Envoyer un message sur ce port
      Message = new DatagramPacket(sendBuf, 256, Adresse_IP, Port);
      try 
	{ 
	  Socket_UDP.send(Message);
	} 
      catch  (IOException e) 
	{
	  System.out.println("Emission ratee ...");
        }      
      
	socket.close();

}
