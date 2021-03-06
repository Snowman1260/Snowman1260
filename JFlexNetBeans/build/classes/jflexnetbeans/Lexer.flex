package jflexnetbeans;;                 /*IMPORTACIONES*/
import static jflexnetbeans.Token.*;
%%                                      /*DEFINICIONES*/
%class Lexer                            /*LA CLASE QUE SE GENERARA SE LLAMA "LEXER" Y ESCRIBE CODIGO AHI*/
%type Token                             /*LOS VALORES SE RETORNAN DE TIPO "TOKEN" */
L = [a-zA-Z_]                           
D = [0-9]
P = [(){}\[\]]
WHITE = [ \t\n\r]
IDENTIFICADOR = {L}({L}|{D})*
VARIABLE = ["$"]{IDENTIFICADOR}

PALABRASRESERVADAS = "__halt_compiler()"|"abstract"|"array()"|"as"|
"callable"|"catch"|"class"|
"clone"|"declare"|
"die()"|"do"|"empty()"|"enddeclare"|"endfor"|"endforeach"|"endif"|
"endswitch"|"endwhile"|"eval()"|"exit()"|"extends"|
"final"|"finally"|"function"|
"global"|"goto"|"implements"|"include"|
"include_once"|"instanceof"|"insteadof"|"interface"|"isset()"|
"list()"|"namespace"|"new"|"or"|"print"|
"private"|"protected"|"public"|"require"|"require_once"|"return"|"static"|"switch"|"throw"|"trait"|
"try"|"unset()"|"use"|"var"|"while"|"xor"|"yield"  

ENTRADA = [<]{WHITE}*[?]{WHITE}*"php"
SALIDA = [?]{WHITE}*[>]

IDENTIDAD = "+"{VARIABLE}
NEGACION = "-"{VARIABLE}
ADICION = {VARIABLE}{WHITE}*"+"{WHITE}*{VARIABLE}
SUBSTRACCION = {VARIABLE}{WHITE}*"-"{WHITE}*{VARIABLE}
MULTIPLICACION = {VARIABLE}{WHITE}*"*"{WHITE}*{VARIABLE}
DIVISION = {VARIABLE}*{WHITE}*"/"{WHITE}*{VARIABLE}
MODULO = {VARIABLE}{WHITE}*"%"{WHITE}*{VARIABLE}
EXPONENCIAL = {VARIABLE}{WHITE}*"**"{WHITE}*{VARIABLE}

OPERADORES_ARITMETICOS = {IDENTIDAD}|{NEGACION}|{ADICION}|{SUBSTRACCION}|{MULTIPLICACION}|{DIVISION}|{MODULO}|{EXPONENCIAL}

AND = {VARIABLE}{WHITE}*"and"{WHITE}*{VARIABLE}
AND2 = {VARIABLE}{WHITE}*"&&"{WHITE}*{VARIABLE}
OR = {VARIABLE}{WHITE}*"or"{WHITE}*{VARIABLE}
OR2 = {VARIABLE}{WHITE}*"||"{WHITE}*{VARIABLE}
XOR = {VARIABLE}{WHITE}*"xor"{WHITE}*{VARIABLE}
NOT = "!"{WHITE}*{VARIABLE}

OPERADORES_LOGICOS = {AND}|{OR}|{XOR}|{NOT}|{AND2}|{OR2}

LOGICOS = ("true"|"false")

DECIMAL = ([1-9]{D}*)|0
HEXADECIMAL = 0[xX][0-9a-fA-F]+
OCTAL = 0[0-7]+
BINARY = 0[bB][01]+

INT = [+-]?{DECIMAL}|[+-]?{HEXADECIMAL}|[+-]?{OCTAL}|[+-]?{BINARY}

LNUM = [0-9]+
DNUM = ({D}*[\.]{LNUM})|({LNUM}[\.]{D}*)
EXPONENT_DNUM = [+-]?(({LNUM}|{DNUM})[Ee][+-]?{LNUM})

FLOAT = {LNUM} | {DNUM} | {EXPONENT_DNUM}

STRING = "echo"{WHITE}*((\")({L}|{WHITE}|{D})*(\")|{VARIABLE}){WHITE}*";"
VARIABLEFINAL = {VARIABLE}{WHITE}*"="{WHITE}*({INT}|{FLOAT}|{LOGICOS}|{VARIABLE}){WHITE}*";"
VARIABLEPARAESTRUCTURAS = ({INT}|{FLOAT}|{LOGICOS})
COMPARADORES= "=="|"==="|"!="|"<>"|"<"|">"|"<="|">="|"<=>"|"??"


DEFINE = "define"{WHITE}*(\(){WHITE}*(\"){L}*(\"){WHITE}*","{WHITE}*(\")({L}|{WHITE})*(\"){WHITE}*(\)){WHITE}*;

IF = "if"{WHITE}*(\(){WHITE}*{VARIABLE}{WHITE}*{COMPARADORES}{WHITE}*({VARIABLE}|{VARIABLEPARAESTRUCTURAS}){WHITE}*(\)){WHITE}*(\{){WHITE}*({VARIABLEFINAL}|{STRING}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{WHITE})*{WHITE}*(\})
ELSEIF = "elseif"{WHITE}*(\(){WHITE}*{VARIABLE}{WHITE}*{COMPARADORES}{WHITE}*({VARIABLE}|{VARIABLEPARAESTRUCTURAS}){WHITE}*(\)){WHITE}*(\{){WHITE}*({VARIABLEFINAL}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{STRING}|{WHITE})*{WHITE}*(\})
ELSE = "else"{WHITE}*(\{){WHITE}*({VARIABLEFINAL}|{STRING}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{WHITE})*{WHITE}*(\})

IFINAL = {IF}+{ELSEIF}*{ELSE}*

WHILE = "while"{WHITE}*(\(){WHITE}*{VARIABLE}{WHITE}*{COMPARADORES}{WHITE}*({VARIABLE}|{VARIABLEPARAESTRUCTURAS}){WHITE}*(\)){WHITE}*(\{){WHITE}*({VARIABLEFINAL}|{STRING}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{WHITE})*{WHITE}*(\})

DOWHILE = "do"{WHITE}*(\{){WHITE}*({VARIABLEFINAL}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{STRING}|{WHITE})*{WHITE}*(\}){WHITE}*"while"{WHITE}*(\(){WHITE}*{VARIABLE}{WHITE}*{COMPARADORES}{WHITE}*({VARIABLE}|{VARIABLEPARAESTRUCTURAS}){WHITE}*(\)){WHITE}*";"

FOR = "for"{WHITE}*(\(){WHITE}*{VARIABLE}{WHITE}*"="{WHITE}*{VARIABLEPARAESTRUCTURAS}{WHITE}*";"{WHITE}*{VARIABLE}{WHITE}*{COMPARADORES}{WHITE}*{VARIABLEPARAESTRUCTURAS}{WHITE}*";"{WHITE}*{VARIABLE}"++"{WHITE}*(\)){WHITE}*(\{){WHITE}*({VARIABLEFINAL}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{STRING}|{WHITE})*{WHITE}*(\})

INCLUDE = "include"{WHITE}*(\')({L}|{D}|{WHITE})+"."({L}|{D})+(\')";"

CASE = "case"{WHITE}*{D}{WHITE}*":"{WHITE}*({VARIABLEFINAL}|{PALABRASRESERVADAS}|{STRING}|{WHITE})*
SWITCH = "switch"{WHITE}*(\(){WHITE}*{VARIABLE}{WHITE}*(\)){WHITE}*(\{){WHITE}*({CASE}|{WHITE})*{WHITE}*(\}){WHITE}*

VARIABLES_PREDETERMINADAS1 = ("$_get"|"$_post"|"$_env"|"$_server"|"$_cookie"|"$_request")
VARIABLE_PREDETERMINADAS2 = ("$get_vars"|"$post_vars"|"$cookie_vars"|"$session_vars"|"$server_vars"|"$env_vars")
VARIABLE_PREDETERMINADAFINAL= {VARIABLE_PREDETERMINADAS2}{WHITE}*"="{WHITE}*{VARIABLES_PREDETERMINADAS1}";"
VARIABLE_PREDETERMINADAFINAL2 = {VARIABLES_PREDETERMINADAS1}{WHITE}*"="{WHITE}*"&$http"{L}*";"

FUNCTION = {L}+{L}*{WHITE}*(\(){WHITE}*({VARIABLE}{WHITE}*",")*({VARIABLE})?(\))(\{)({VARIABLEFINAL}|{PALABRASRESERVADAS}{WHITE}*{VARIABLE}";"|{STRING}|{WHITE})*(\})
IDENTIFICADOR2 = {L}+{L}*(\()(\))";"

COMENTARIOS = "//"({L}|{D}|{WHITE})* | "/*"({L}|{D}|{WHITE})*"*/" | "#"({L}|{D}|{WHITE})*

BASE_DE_DATOS = {VARIABLE}(\[)(\'){L}*(\')(\])




%{
public String lexeme;
%}
%%
{WHITE} {}                            /*IGNORA ESPACIOS EN BLANCO*/
"//".*                               /*EL PUNTO HACE REFERENCIA A CUALQUIER CARACTER EXCEPTUANDO EL RETORNO DE CARRO.*/
"=" {return ASIG;}                 
"==" {return IGUAL;}
"+" {return MAS;}
"*" {return MUL;}
"-" {return MENOS;}
"if" {return COND;}
[-+]?{D}+\.{D}+                 {lexeme=yytext(); return REAL;}
{PALABRASRESERVADAS}                                        {lexeme=yytext(); return PALABRASRESERVADAS;}
{ENTRADA}                                                   {lexeme=yytext(); return ENTRADA;}
{SALIDA}                                                    {lexeme=yytext(); return SALIDA;}
{OPERADORES_ARITMETICOS}|{OPERADORES_LOGICOS}               {lexeme=yytext(); return OPERADORES;}
{STRING}                                                    {lexeme=yytext(); return STRING;}
{VARIABLEFINAL}                                             {lexeme=yytext(); return VARIABLEFINAL;}
{IFINAL}                                                    {lexeme=yytext(); return IFINAL;}
{COMENTARIOS}                                               {lexeme=yytext(); return COMENTARIOS;}
{DEFINE}                                                    {lexeme=yytext(); return DEFINE;}
{WHILE}                                                     {lexeme=yytext(); return WHILE;}
{DOWHILE}                                                   {lexeme=yytext(); return DOWHILE;}
{FOR}                                                       {lexeme=yytext(); return FOR;}
{INCLUDE}                                                   {lexeme=yytext(); return INCLUDE;}
{SWITCH}                                                    {lexeme=yytext(); return SWITCH;}
{VARIABLE_PREDETERMINADAFINAL}                              {lexeme=yytext(); return VARIABLE_PREDETERMINADAFINAL;}
{VARIABLE_PREDETERMINADAFINAL2}                             {lexeme=yytext(); return VARIABLE_PREDETERMINADA2;}
{FUNCTION}                                                  {lexeme=yytext(); return FUNCTION;}
{IDENTIFICADOR2}                                            {lexeme=yytext(); return IDENTIFICADOR;}
{BASE_DE_DATOS}                                             {lexeme=yytext(); return BASE_DE_DATOS;}



{P} {return SEP;}
. {return ERROR;}
