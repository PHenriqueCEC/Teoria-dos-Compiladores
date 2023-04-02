package compilers;

public class Token {

    public int linha, coluna;
    public TokenType token;
    public String lexeme; //caracteres que forma um token


    private boolean palavrasReservadas() {
        return (token == TokenType.RETURN || token == TokenType.IF);
    }

    private boolean operadores() {
        return (token == TokenType.ADDITION || token == TokenType.DIVISION ||
        token == TokenType.MULTIPLICATION || token == TokenType.SUBTRATCION);
    }

}
