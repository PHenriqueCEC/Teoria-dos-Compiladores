import java.io.IOException;
import java.io.FileReader;
import java.util.HashMap;

public class App {

    public static void main(String[] args) throws IOException {

        System.out.println("Hello java");

        HashMap<Integer, String> tokens = new HashMap<Integer, String>();
        Integer contTokens = 0;

        FileReader inputFile = new FileReader(args[0]);

        Token token = null; // Precisa inicializar

        while (token != null) {

            contTokens++;
        }

        System.out.println("Quantidade de Tokens coletados: " + contTokens);
    }

}