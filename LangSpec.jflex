/*  
    Matheus Gomes Luz Werneck (201835037) 
    Pedro Henrique Almeida Cardoso Reis (201835039)
*/
%%

%unicode
%line
%column
%class LexicalAnalyzer
%function nextToken
%type Token

%{
    private int numberOfTokensReaded;

    
    public int readedTokens(){
       return numberOfTokensReaded;
    }
    private Token symbol(TOKEN_TYPE t) {
        numberOfTokensReaded++;
        return new Token(t,yytext(), yyline+1, yycolumn+1);
        
    }
    private Token symbol(TOKEN_TYPE t, Object value) {
        numberOfTokensReaded++;
        return new Token(t, value, yyline+1, yycolumn+1);
    }
%}

%init{
    numberOfTokensReaded = 0; // Isto é copiado direto no construtor do lexer. 
%init}

  endOfLine  = \r|\n|\r\n
  whitespace     = {endOfLine} | [ \t\f]
  int     = [:digit:]+
  float        = [:digit:]*\.[:digit:]+
  whiteSpaceChars = \\t | \\n | \\b | \\r
  char         = '([:uppercase:] | [:lowercase:] | \\ | \\' | {whiteSpaceChars})'
  bool= "true" | "false"
  
  identifier = [:lowercase:]+ ( [:lowercase:]* [_]* [:uppercase:]* [:digit:]* ) *
  lineComment = "--" (.)* {endOfLine}

  reservedWord = "if" | "then" | "else" | "iterate" | "read" | "print" | "return" 
  typeName = [:uppercase:] [:lowercase:]+ ([:uppercase:] | [:lowercase:])+

  
%state COMMENT

%%
//Referente ao processamento dos Tokens. Encontramos os tokens e returnamos ele
<YYINITIAL>{
    {whitespace}    {}
    {bool}       { return symbol(TOKEN_TYPE.BOOL);}
    "null"          { return symbol(TOKEN_TYPE.NULL);  }
    {reservedWord}  { return symbol(TOKEN_TYPE.RESERVED_WORD);}
    {typeName}      { return symbol(TOKEN_TYPE.TYPE);}
    {char}          { return symbol(TOKEN_TYPE.CHAR);}
    {identifier}    { return symbol(TOKEN_TYPE.ID);   }
    {int}       { return symbol(TOKEN_TYPE.INT, Int.parseInt(yytext()) );  }
    {float}         { return symbol(TOKEN_TYPE.FLOAT); }
    {lineComment}   {}
    "{-"            { yybegin(COMMENT);               }
    "=="            { return symbol(TOKEN_TYPE.EQUAL);}
    "="             { return symbol(TOKEN_TYPE.EQ);   }
    ";"             { return symbol(TOKEN_TYPE.SEMI); }
    "*"             { return symbol(TOKEN_TYPE.TIMES); }
    "+"             { return symbol(TOKEN_TYPE.PLUS); }
    "-"             { return symbol(TOKEN_TYPE.MINUS); }
    "/"             { return symbol(TOKEN_TYPE.DIVISION); }
    "<"             { return symbol(TOKEN_TYPE.LESS_THAN); }
    ">"             { return symbol(TOKEN_TYPE.BIGGER_THAN); }
    "%"             { return symbol(TOKEN_TYPE.PERCENT_SIGN);}
    ","             { return symbol(TOKEN_TYPE.COMMA);}
    "."             { return symbol(TOKEN_TYPE.DOT);}
    "&&"            { return symbol(TOKEN_TYPE.CONJUNCTION);}
    "::"            { return symbol(TOKEN_TYPE.TYPE_ATTRIBUTTION);}
    ":"             { return symbol(TOKEN_TYPE.RETURN_TYPE_ATTRIBUTTION);}
    "!="            { return symbol(TOKEN_TYPE.DIFFERENCE);}
    "!"             { return symbol(TOKEN_TYPE.LOGICAL_NEGATION);}
    "("             { return symbol(TOKEN_TYPE.OPEN_PARENTHESIS);}
    ")"             { return symbol(TOKEN_TYPE.CLOSE_PARENTHESIS);}
    "'"             { return symbol(TOKEN_TYPE.QUOTATION);}
    "\\"            { return symbol(TOKEN_TYPE.BACKSLASH);}
    "{"             { return symbol(TOKEN_TYPE.OPEN_BRACKETS);}
    "}"             { return symbol(TOKEN_TYPE.CLOSE_BRACKETS);}
    "["             { return symbol(TOKEN_TYPE.OPEN_ANGLEBRACKETS);}
    "]"             { return symbol(TOKEN_TYPE.CLOSE_ANGLEBRACKETS);}
}

<COMMENT>{
   "-}"     { yybegin(YYINITIAL); }     
   [^"-}"]* {                     }
}



[^] { 
    throw new RuntimeException("Illegal character <"+yytext()+">" + " at line : " + (yyline+1) + " and column: " + (yycolumn+1)); 
    }



