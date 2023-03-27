package compilers;

public enum TokenType {
    SUBTRATCION("-"),
    ADDITION("+"),
    MULTIPLICATION("*"),
    DIVISION("/"),
    NOTHING("");

    private final String tokenMeaning;

    TokenType(String tokenMeaning) {
        this.tokenMeaning = tokenMeaning;
    }

    public String getTokenMeaning() {
        return tokenMeaning;
    }


}
