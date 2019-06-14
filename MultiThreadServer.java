package com.company;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

public class MultiThreadServer {
    public static ArrayList<PrintWriter> clients = new ArrayList<>();

    public static void main(String[] args) {


        ServerSocket server = null;
        try {
            server = new ServerSocket(32000);
            server.setReuseAddress(true);
            // The main thread is just accepting new connections
            while (true) {
                Socket client = server.accept();
                System.out.println("New client connected " + client.getInetAddress().getHostAddress());
                ClientHandler clientSock = new ClientHandler(client);
//                clients.add(clientSock.getClient());
//                clients.add(clientSock.getClient());
                System.out.print(clients);
                // The background thread will handle each client separately
                new Thread(clientSock).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (server != null) {
                try {
                    server.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static class ClientHandler implements Runnable {

        private final Socket clientSocket;
        PrintWriter out = null;
        public ClientHandler(Socket socket) {
            this.clientSocket = socket;

        }

        public PrintWriter getClient(){

            return out;
        }

        @Override
        public void run() {
            BufferedReader in = null;
            try {
                out = new PrintWriter(clientSocket.getOutputStream(), true);
                if(!clients.contains(out)){
                    clients.add(out);
                }
                in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                String line;
                while ((line = in.readLine()) != null) {
                    int noRec = clients.indexOf(out);
                    System.out.println(noRec);
                    for(int i = 0; i < clients.size(); i++){
                        if(i != (noRec+1)){
                            System.out.println("Sent to:"+ i +"-----"+ out+"------"+(noRec+1));
                            clients.get(i).println(line);
                        }
                    }

                }

            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (out != null) {
                        out.close();
                    }
                    if (in != null)
                        in.close();
                    clientSocket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
