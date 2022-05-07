%{
#include "y.tab.h"
#include "string.h"
void yyerror(char* s);
%}

%%
"Play"                      { return play; }
"I want to choose"          { return choose_character; }
"Get a job"                 { return list_job; }
"Get job"                   { return get_job; }
"Work"                      { return work; }
"See my account balance"    { return account_balance; }
"See my experience"         { return experience; }
"See my property"           { return property; }
"Buy a car"                 { return list_car; }
"Buy car"                   { return get_car; }
"Buy a house"               { return list_house; }
"Buy house"                 { return get_house; }
"Go to casino"              { return list_casino; }
"Dice"                      { return dice; }
"I want to bet"             { return bet; }
"Exit casino"               { return exit_casino; }
"Rob"                       { return rob; }
"Go to party"               { return party; }
"Buy a business"            { return list_business; }
"Buy business"              { return business; }
"Check on my business"      { return check_business; }
"Withdraw"                  { return withdraw; }
"from my business"          { return from_business; }
"Quit"                      { return quit; }
"Sell business"             { return sell_business; }
[0-9]+                      { yylval.integer = atoi(yytext); return value; }
[A-Z][a-zA-Z]+              { yylval.string = strdup(yytext); return name; }
[ \t\n]                     ;
.                           ;
%%

int yywrap (void) { return 1; }