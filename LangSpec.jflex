
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
  identifier = [:lowercase:]+ ( [:lowercase:]* [_]* [:uppercase:]* ) *
  lineComment = "//" (.)* {endOfLine}
  type= "Int" | "Char" | "Bool" | "Float"
  reservedWord = "if" | "else" | "iterate" | "read" | "print" | "return"
  boolean= "true" | "false"

  
%state COMMENT

%%

<YYINITIAL>{
    {identifier} { return symbol(TOKEN_TYPE.ID);   }
    {integer}      { return symbol(TOKEN_TYPE.NUM, Integer.parseInt(yytext()) );  }
    "="             { return symbol(TOKEN_TYPE.EQ);   }
    ";"             { return symbol(TOKEN_TYPE.SEMI); }
    "*"             { return symbol(TOKEN_TYPE.TIMES); }
    "+"             { return symbol(TOKEN_TYPE.PLUS); }
    "-"             { return symbol(TOKEN_TYPE.MINUS); }
    "/*"            { yybegin(COMMENT);               }
    "<"             { return symbol(TOKEN_TYPE.LESS_THAN); }
    ">"             { return symbol(TOKEN_TYPE.BIGGER_THAN); }
    {whitespace}    {}
    {lineComment}   {}
    {type}          { return symbol(TOKEN_TYPE.TYPE);}
    {reservedWord}  { return symbol(TOKEN_TYPE.RESERVED_WORD);}
    "::"            { return symbol(TOKEN_TYPE.TYPE_ATTRIBUTTION);}
    ":"             { return symbol(TOKEN_TYPE.RETURN_TYPE_ATTRIBUTTION);}
    "("             { return symbol(TOKEN_TYPE.OPEN_PARENTHESIS);}
    ")"             { return symbol(TOKEN_TYPE.CLOSE_PARENTHESIS);}
    "{"             { return symbol(TOKEN_TYPE.OPEN_BRACKETS);}
    "}"             { return symbol(TOKEN_TYPE.CLOSE_BRACKETS);}
    "["             { return symbol(TOKEN_TYPE.OPEN_ANGLEBRACKETS);}
    "]"             { return symbol(TOKEN_TYPE.CLOSE_ANGLEBRACKETS);}
    {boolean}       {return symbol(TOKEN_TYPE.BOOLEAN);}
    
    
}

<COMMENT>{
   "*/"     { yybegin(YYINITIAL); }     
   [^"*/"]* {                     }
}



[^] { throw new RuntimeException("Illegal character <"+yytext()+">" + " at line : " + yyline + " and column: " + yycolumn); }



