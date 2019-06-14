package com.company;
import java.lang.*;
public class Main {

    public static void main(String[] args) {
    outputThread output = new outputThread();
    inputThread input = new inputThread();
    input.start();
    output.start();
    }
}
