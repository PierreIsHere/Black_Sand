package com.company;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class outputThread extends Thread{
    @Override
    public void run() {
        String host = "127.0.0.1";
        int port = 32000;
        try (Socket socket = new Socket(host, port)) {
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            while (true) {
                System.out.println("Server replied " + in.readLine());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}