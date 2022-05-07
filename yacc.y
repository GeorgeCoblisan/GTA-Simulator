 %{
    void yyerror (char *s);
    #include <stdio.h>     
    #include <stdlib.h> 
    #include <string.h>
    #include <ctype.h>

    int my_wallet = 0;
    int my_experience = 0;
    int character_chosed = 0;
    char my_cars[20][5];
    char my_house[20];
    char my_business[20];
    int my_property = 0;

    void addMoneyAndExperienceByCharacter(char *character);
    void exit_game();
    void print_jobs();
    void see_wallet();
    void see_my_property();
    void see_my_experience();
%}

%start line
%union { int integer; char* string; }
%token play
%token choose_character
%token list_job
%token get_job
%token work
%token account_balance
%token experience
%token property
%token list_car
%token get_car
%token list_house
%token get_house
%token list_casino
%token dice
%token bet
%token exit_casino
%token rob
%token party
%token list_business
%token business
%token check_business
%token withdraw
%token from_business
%token quit
%token sell_business
%token <integer> value
%token <string> name

%%

line : play { printf("Welcome to GTA Simulator! Please select a character between: CJ or Trevor or Ryder. Use 'I want to choose X' command.\n"); }
     | line play { }
     | choose_person { }
     | line choose_person { }
     | quit { exit_game(); }
     | line quit { exit_game(); }
     | list_job { print_jobs(); }
     | line list_job { print_jobs(); }
     | account_balance { see_wallet(); }
     | line account_balance { see_wallet(); }
     | experience { see_my_experience(); }
     | line experience { see_my_experience(); }
     | property { see_my_property(); }
     | line property { see_my_property(); }

choose_person : choose_character name { addMoneyAndExperienceByCharacter($2); }

%%

void addMoneyAndExperienceByCharacter(char *character) {
    int exist = 1;
    if (character_chosed == 0) {
        if (strcmp(character, "CJ") == 0) {
            my_wallet += 12000;
            my_experience += 20;
        }
        else if (strcmp(character, "Ryder") == 0) {
            my_wallet += 10000;
            my_experience += 15;
        }
        else if (strcmp(character, "Trevor") == 0) {
            my_wallet += 11000;
            my_experience += 18;
        }
        else {
            printf("This character doesn't exist!\n");
            exist = 0;
        }
        if (exist) {
            character_chosed = 1;
            printf("Congratulations! You got %d$ and %d XP. Good luck and enjoy the game!\nTry our game systems with the following commands: Get a job, See my account balance, See my property, See my experience, Buy a business, Buy a house, Buy a car, Go to party, Go to casino, Rob.\n", my_wallet, my_experience);
        }
    }
    else {
        printf("The character has already been chosen! Use 'Quit' if you want to exit and choose another one.\n");
    }
}

void exit_game() {
    printf("Have a nice day! Hope to see you again very soon!\n");
    exit(1);
}

void print_jobs() {
    if (character_chosed == 1) {
        printf("Welcome to our jobs! Choose the job that suits you based on your experience. Use “Get job X” command. The available jobs are:\n");
        printf("Trucker – 0 XP.\n");
        printf("Farmer – 30 XP.\n");
        printf("Lumberjack – 50 XP.\n");
        printf("Miner – 70 XP.\n");
        printf("Drugs Dealer – 100 XP.\n");
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void see_wallet() {
    printf("Your wallet: %d$\n", my_wallet);
}

void see_my_property() {
    if (my_property == 0) {
        printf("You don’t have any property!\n");
    }
    if (strlen(my_cars[0]) != 0) {
        my_property = 1;
        printf("Your cars: ");
        for (int i=0; i<5; i++) {
            printf("%s ", my_cars[i]);
        }
        printf("\n");
    }
    if (strlen(my_house) != 0) {
        my_property = 1;
        printf("Your house: %s\n", my_house);
    }
    if (strlen(my_business) != 0) {
        my_property = 1;
        printf("Your business: %s\n", my_business);
    }
}

void see_my_experience() {
    printf("Your experience: %d XP\n", my_experience);
}

int main(void) {
    return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 