package hello;


import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.xml.ws.Endpoint;
@WebService

public class CircleFunctions {
   @WebMethod public double getArea(double r) {
       return java.lang.Math.PI * (r * r);
    }

   @WebMethod public double getCircumference(double r) {
        return 2 * java.lang.Math.PI * r;
    }



public static void main(String[] args) {

      Endpoint.publish(
         "http://localhost:8080/WebServiceExample/circlefunctions",
         new CircleFunctions());

	}
}
