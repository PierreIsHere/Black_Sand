

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class inputThread extends Thread{
    String ipAddress ;
    int line;
    public inputThread(String ipAddr){
        ipAddress = ipAddr;
    }
    public void getInput(int kPress){
       this.line = kPress;
    }
    @Override
    public void run() {

        String host = ipAddress;
        int port = 32000;
        try  {
          Socket socket = new Socket(host, port);
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            
            while (true) {
               
                out.println(keyPressed? key:null);
                out.flush();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
