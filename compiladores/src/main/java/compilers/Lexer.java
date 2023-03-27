package compilers;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Lexer {
    private Scanner scanner;
    private TokenType tokenType;

    public Lexer(File inputFile) throws FileNotFoundException {
        scanner = new Scanner(inputFile);
    }

    public Token getNextToken() {

        //Codigo para pegar o proximo token

    }

    private TokenType identifyTokenType(String tokenCatch) {

        if(tokenCatch.equals("-")) {
            return tokenType.SUBTRATCION;
        }

        else if(tokenCatch.equals("+")) {
            return tokenType.ADDITION;
        }

        else if(tokenCatch.equals(("*"))) {
            return tokenType.MULTIPLICATION;
        }

        else if(tokenCatch.equals("/")) {
            return tokenType.DIVISION;
        }

        else {
            return tokenType.NOTHING;
        }


    }



}