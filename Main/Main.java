package com.company;
import java.lang.*;
public class Main {

    public static void main(String[] args) {
        String ipAddr = "72.141.8.213";
        outputThread output = new outputThread(ipAddr);
        inputThread input = new inputThread(ipAddr);
        input.start();
        output.start();
    }
}
