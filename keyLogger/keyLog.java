package com.company.keyLogger;

import java.io.IOException;

public class keyLog {


    public static void main(String[] args) {
        try {
            Runtime runTime = Runtime.getRuntime();

            String executablePath = "C:\\Users\\Azfar\\Desktop\\tocompile\\dist\\keyBoard.exe";

            Process process = runTime.exec(executablePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}