package com.company;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class inputThread extends Thread{
    String ipAddress ;
    public inputThread(String ipAddr){
        ipAddress = ipAddr;
    }
    @Override
    public void run() {

        String host = ipAddress;
        int port = 32000;
        try (Socket socket = new Socket(host, port)) {
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            Scanner scanner = new Scanner(System.in);
            String line = null;
            while (!"exit".equalsIgnoreCase(line)) {
                line = scanner.nextLine();
                out.println(line);
                out.flush();
            }
            scanner.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}