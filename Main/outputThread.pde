
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class outputThread extends Thread{
    String ipAddress;

    public outputThread(String ipAddr){
        ipAddress = ipAddr;
    }
    @Override
    public void run() {
        String host = ipAddress;
        int port = 32000;
        try  {
            Socket socket = new Socket(host, port);
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            while (true) {
                System.out.println(in.readLine());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
