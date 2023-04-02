package compilers;

import java.io.IOException;
import java.io.FileReader;

import java.util.HashMap;

public class Main {

    public static void Main(String[] args) throws IOException {

        HashMap<Integer, String> tokens = new HashMap<Integer, String>();
        Integer contTokens = 0;

        FileReader inputFile = new FileReader(args[0]);

        Token token; //Precisa inicializar

        while(token != null) {
            

            contTokens++;
        }


        System.out.println("Quantidade de Tokens coletados: " + contTokens);  


    }
    
}
