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
    int my_property = 0;
    int current_job = -1;
    bool casino_mode = false;

    typedef struct Item{
        char item_name[20];
        int price;
    };

    struct Item my_cars[10];
    struct Item my_house;
    struct Item my_business;

    struct Item cars_list[] = {
        { .item_name = "ROLLS ROYCE", .price = 60000 },
        { .item_name = "ASTON MARTIN", .price = 30000 },
        { .item_name = "BMW M8", .price = 20000 },
    };

    int iter_cars = 0, iter_house = 0, iter_business = 0;

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
    void print_cars();
    int buy_car(char* car_name);
%}

%start line
%union { int integer; char* string; }
%token play choose_character get job work see account_balance experience 
%token property buy car house go_to casino dice bet leave rob party business check withdraw from quit sell invalid
%token <integer> value
%token <string> name


%%

line : play { printf("Welcome to GTA Simulator! Please select a character between: CJ or Trevor or Ryder. Use 'I want to choose X' command.\n"); }
     | line play { }
     | line choose_person { }
     | line leave { exit_game(); }
     | line job_topic { }
     | line car_topic { }
     | line house_topic { }
     | line business_topic { }
     | line casino_topic { }
     | line check_topic{ }
     | line party { go_to_party(); }
     | line invalid { printf("NO"); }
     | /* NULL */;

job_topic   : get job { print_jobs(); }
            | get job name { get_new_job($3); }
            | work { work_job(); }

car_topic   : buy car { print_cars(); }
            | buy car name { buy_car($3); }

house_topic : buy house {}
            | buy house name {}

business_topic: buy business {}
              | buy business name {}
              | check business {}
              | withdraw from business {}
              | sell business {}

casino_topic  : go_to casino { print_casino(); }
              | dice { print_dice(); }
              | bet value { make_bet($2); }
              | leave casino { leave_casino(); }

check_topic   : see account_balance { see_wallet(); }
              | see experience { see_my_experience(); }
              | see property { see_my_property(); }

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
    if (iter_cars != 0) {
        my_property = 1;
        printf("Your cars: ");
        for (int i=0; i<3; i++) {
            printf("%s ", my_cars[i].item_name);
        }
        printf("\n");
    }
    if (iter_house != 0) {
        my_property = 1;
        printf("Your house: %s\n", my_house.item_name);
    }
    if (iter_business != 0) {
        my_property = 1;
        printf("Your business: %s\n", my_business.item_name);
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
        if (strcmp(jobName, "TRUCKER") == 0) {
            if (my_experience >= 0) {
                current_job = 0;
                printf("Congratulations! You become a %s. To start working use 'Work' command.\n", jobName);
            }
            else {
                printf("You don't have enough experience to get this job!\n");
            }
        }
        else if (strcmp(jobName, "FARMER") == 0) {
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
        else if (strcmp(jobName, "MINER") == 0) {
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

void print_cars(){
    if (character_chosed == 1) {
        printf("Welcome to the car shop! To buy a car use “Buy car X” command. The available cars are:\n");
        for(int i=0; i<3; i++){
            printf("%s %d$\n", cars_list[i].item_name, cars_list[i].price);
        }
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

int buy_car(char* car_name){
    if(character_chosed == 0){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    int ok = 1;
    for(int i=0; i<3; i++){
            if(strcmp(cars_list[i].item_name, car_name)==0){
                if(my_wallet >= cars_list[i].price){
                    my_wallet -= cars_list[i].price;
                    printf("You bought the %s car for %d\n", cars_list[i].item_name, cars_list[i].price);
                    my_cars[iter_cars++] = cars_list[i];
                }else{
                    printf("You do not have %d $! You only have %d $\n", cars_list[i].price, my_wallet);
                }
            }
            ok = 0;
        }

    if(!ok){
         printf("Car does not exist");
         return 0;
    }

    return 1;
}

int main(void) {


    return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 