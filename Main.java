package com.company;
import java.lang.*;
public class Main {

    public static void main(String[] args) {
        String ipAddr = "127.0.0.1";
        outputThread output = new outputThread(ipAddr);
        inputThread input = new inputThread(ipAddr);
        input.start();
        output.start();
    }
}
