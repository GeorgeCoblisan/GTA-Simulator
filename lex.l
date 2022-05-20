%{
#include "y.tab.h"
#include "string.h"
void yyerror(char* s);
%}

%%
"Play"                      { return play; }
"I want to choose"          { return choose_character; }
"Get"                       { return get; }
"job"                       { return job; }
"Work"                      { return work; }
"See my"                    { return see; }
"wallet"                    { return account_balance; }
"experience"                { return experience; }
"property"                  { return property; }
"Buy"                       { return buy; }
"car"                       { return car; }
"house"                     { return house; }
"Go to"                     { return go_to; }
"casino"                    { return casino; }
"Dice"                      { return dice; }
"I want to bet"             { return bet; }
"Exit"                      { return leave; }
"Rob"                       { return rob; }
"party"                     { return party; }
"business"                  { return business; }
"Check on my"               { return check; }
"Withdraw"                  { return withdraw; }
"from my"                   { return from; }
"Sell"                      { return sell; }
"businesses"                { return businesses; }
"cars"                      { return cars; }
"houses"                    { return houses; }   
"jobs"                      { return jobs; } 
[A-Z]+                      { yylval.string = strdup(yytext); return name; }
[A-Z]+[ ][A-Z0-9]+          { yylval.string = strdup(yytext); return name; }
[0-9]+                      { yylval.integer = atoi(yytext); return value; }
[ \t\n]                     ;
.                           {return invalid;}
%%

int yywrap (void) { return 1; }