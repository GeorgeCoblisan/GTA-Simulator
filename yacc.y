 %{
    void yyerror (char *s);
    #include <stdio.h>     
    #include <stdlib.h> 
    #include <string.h>
    #include <ctype.h>
    #include <stdbool.h>

    int my_wallet = 0;
    int my_experience = 0;
    int character_chosed = 0;
    char my_cars[20][5];
    char my_house[20];
    char my_business[20];
    int my_property = 0;
    int current_job = -1;
    bool casino_mode = false;

    void addMoneyAndExperienceByCharacter(char *character);
    void exit_game();
    void print_jobs();
    void see_wallet();
    void see_my_property();
    void see_my_experience();
    void print_houses();
    void print_business();
    void get_new_job();
    void work_job();
    void print_casino();
    void print_dice();
    void leave_casino();
    void make_bet();
    void go_to_party();
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
     | list_house { print_houses(); }
     | line list_house { print_houses(); }
     | list_business { print_business(); }
     | line list_business { print_business(); }
     | choose_job { }
     | line choose_job { }
     | work { work_job(); }
     | line work { work_job(); }
     | list_casino { print_casino(); }
     | line list_casino { print_casino(); }
     | dice { print_dice(); }
     | line dice { print_dice(); }
     | exit_casino { leave_casino(); }
     | line exit_casino { leave_casino(); }
     | choose_bet { }
     | line choose_bet { }
     | party { go_to_party(); }
     | line party { go_to_party(); }

choose_person : choose_character name { addMoneyAndExperienceByCharacter($2); }

choose_job : get_job name { get_new_job($2); }

choose_bet: bet value { make_bet($2); }

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

void print_houses() {
    if (character_chosed == 1) {
        printf("Welcome to our city! To buy a house use “Buy house X” command. The available houses are:\n");
        printf("Small House – 40.000$.\n");
        printf("Medium House – 50.000$.\n");
        printf("Big House – 60.000$.\n");
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void print_business() {
    if (character_chosed == 1) {
        printf("Welcome in our business world! To buy a business use “Buy business X” command. The available business are:\n");
        printf("Restaurant – 40.000$\n");
        printf("Gas Station – 50.000$\n");
        printf("Car Service – 60.000$\n");
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void get_new_job(char *jobName) {
    if (character_chosed == 1) {
        if (strcmp(jobName, "Trucker") == 0) {
            if (my_experience >= 0) {
                current_job = 0;
                printf("Congratulations! You become a %s. To start working use 'Work' command.\n", jobName);
            }
            else {
                printf("You don't have enough experience to get this job!\n");
            }
        }
        else if (strcmp(jobName, "Farmer") == 0) {
            if (my_experience >= 30) {
                current_job = 1;
                printf("Congratulations! You become a %s. To start working use 'Work' command.\n", jobName);
            }
            else {
                printf("You don't have enough experience to get this job!\n");
            }
        }
        else if (strcmp(jobName, "Lumberjack") == 0) {
            if (my_experience >= 50) {
                current_job = 2;
                printf("Congratulations! You become a %s. To start working use 'Work' command.\n", jobName);
            }
            else {
                printf("You don't have enough experience to get this job!\n");
            }
        }
        else if (strcmp(jobName, "Miner") == 0) {
            if (my_experience >= 70) {
                current_job = 3;
                printf("Congratulations! You become a %s. To start working use 'Work' command.\n", jobName);
            }
            else {
                printf("You don't have enough experience to get this job!\n");
            }
        }
        else if (strcmp(jobName, "Drugs Dealer") == 0) {
            if (my_experience >= 100) {
                current_job = 4;
                printf("Congratulations! You become a %s. To start working use 'Work' command.\n", jobName);
            }
            else {
                printf("You don't have enough experience to get this job!\n");
            }
        }
        else {
            printf("This job doesn't exist!\n");
        }
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void work_job() {
    if (character_chosed == 1) {
        if (current_job == 0) {
            my_experience += 3;
            my_wallet += 1200;
            printf("Trucker job: You got 1.200$ and 3 XP.\n");
        }
        else if (current_job == 1) {
            my_experience += 4;
            my_wallet += 1500;
            printf("Farmer job: You got 1.500$ and 4 XP.\n");
        }
        else if (current_job == 2) {
            my_experience += 5;
            my_wallet += 1800;
            printf("Lumberjack job: You got 1.800$ and 5 XP.\n");
        }
        else if (current_job == 3) {
            my_experience += 7;
            my_wallet += 2000;
            printf("Miner job: You got 2.000$ and 7 XP.\n");
        }
        else if (current_job == 4) {
            my_experience += 10;
            my_wallet += 3000;
            printf("Drugs Dealer job: You got 3.000$ and 10 XP.\n");
        }
        else {
            printf("You don't have a job! Please use 'Get job' command!\n");
        }
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void print_casino() {
    if (character_chosed == 1) {
        printf("Welcome to our casino! To start playing use 'Dice' command. To leave the casino use 'Exit casino' command.\n");
        casino_mode = true;
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void print_dice() {
    if (casino_mode) {
        printf("Hi! Please type the amount of money you want to bet with 'I want to bet X money' command.\n");
    }
    else {
        printf("You have to go to casino first! Please use 'Go to casino' command.\n");
    }
}

void make_bet(int amount) {
    if (casino_mode) {
        if (my_wallet >= amount) {
            int my_roll = rand() % 5 + 1;
            int PC_roll = rand() % 5 + 1;
            if (my_roll == PC_roll) {
                printf("You roll %d and PC rolls %d. Tie!\n", my_roll, PC_roll);
            }
            else if (my_roll > PC_roll) {
                printf("You roll %d and PC rolls %d. You win!\n", my_roll, PC_roll);
                my_wallet += amount;
            }
            else if (my_roll < PC_roll) {
                printf("You roll %d and PC rolls %d. You lose!\n", my_roll, PC_roll);
                my_wallet -= amount;
            }
        }
        else {
            printf("You don't have enough money to place this bet!\n");
        }
    }
    else {
        printf("You have to go to casino first! Please use 'Go to casino' command.\n");
    }
}

void leave_casino() {
    printf("Bye! We hope to see you again soon!\n");
    casino_mode = false;
}

void go_to_party() {
    if (character_chosed == 1) {
        int money_spent = rand() % 10000;
        if (my_wallet - money_spent < 0) {
            while (my_wallet - money_spent < 0) {
                money_spent = rand() % 10000;
            }
        }
        my_wallet -= money_spent;
        printf("You got drunk and did a lot of things last night! You losed %d$!\n", money_spent);
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }   
}

int main(void) {
    return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 