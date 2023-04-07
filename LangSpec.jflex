
 /*  Esta seção é copiada antes da declaração da classe do analisador léxico.
  *  É nesta seção que se deve incluir imports e declaração de pacotes.
  *  Neste exemplo não temos nada a incluir nesta seção.
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

  
  /* Agora vamos definir algumas macros */
  endOfLine  = \r|\n|\r\n
  whitespace     = {endOfLine} | [ \t\f]
  integer      = [:digit:] [:digit:]*
  char         = \'[:uppercase:] | [:lowercase:]\' 
  identifier = [:lowercase:]+ ( [:lowercase:]* [_]* [:uppercase:]* ) *
  lineComment = "--" (.)* {endOfLine}
  type= "Int" | "Char" | "Bool" | "Float"
  reservedWord = "if" | "else" | "iterate" | "read" | "print" | "return"
  boolean= "true" | "false"

  
%state COMMENT

%%

<YYINITIAL>{
    {boolean}      { return symbol(TOKEN_TYPE.BOOLEAN);}
    "null"          { return symbol(TOKEN_TYPE.NULL);  }
    {reservedWord}  { return symbol(TOKEN_TYPE.RESERVED_WORD);}
    {type}          { return symbol(TOKEN_TYPE.TYPE);}
    {char}          { return symbol(TOKEN_TYPE.CHAR);}
    {identifier}    { return symbol(TOKEN_TYPE.ID);   }
    {integer}       { return symbol(TOKEN_TYPE.NUM, Integer.parseInt(yytext()) );  }
    {whitespace}    {}
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
    "!="            { return symbol(TOKEN_TYPE.DIFFERENCE);}
    "&&"            { return symbol(TOKEN_TYPE.CONJUNCTION);}
    "::"            { return symbol(TOKEN_TYPE.TYPE_ATTRIBUTTION);}
    ":"             { return symbol(TOKEN_TYPE.RETURN_TYPE_ATTRIBUTTION);}
    "!="            { return symbol(TOKEN_TYPE.DIFFERENCE);}
    "!"             { return symbol(TOKEN_TYPE.LOGICAL_NEGATION);}
    "("             { return symbol(TOKEN_TYPE.OPEN_PARENTHESIS);}
    ")"             { return symbol(TOKEN_TYPE.CLOSE_PARENTHESIS);}
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
    throw new RuntimeException("Illegal character <"+yytext()+">" + " at line : " + yyline+1 + " and column: " + yycolumn+1); 
    }



