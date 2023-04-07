import java.io.IOException;
import java.io.FileReader;

public class App {

    public static void main(String[] args) throws IOException {
        LexicalAnalyzer lx = new LexicalAnalyzer(new FileReader(args[0]));
        Token t = lx.nextToken();

        while (t != null) {
            System.out.println(t.toString());
            t = lx.nextToken();
        }
        System.out.println("Total de tokens lidos " + lx.readedTokens());
    }

}