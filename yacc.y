 %{
    void yyerror (char *s);
    #include <stdio.h>     
    #include <stdlib.h> 
    #include <string.h>
    #include <ctype.h>
    #include <stdbool.h>
    #include <time.h>

    int my_wallet = 0;
    int my_experience = 0;
    int character_chosed = 0;
    int my_property = 0;
    int current_job = -1;
    bool casino_mode = false;
    int nr_good = 0;

    typedef struct Item{
        char item_name[20];
        int price;
    };

    typedef struct Business{
        char item_name[20];
        int price;
        int turnover;
    };

    struct Item my_cars[10];
    struct Item my_house;
    struct Business my_business;

    struct Item cars_list[] = {
        { .item_name = "ROLLS ROYCE", .price = 60000 },
        { .item_name = "ASTON MARTIN", .price = 30000 },
        { .item_name = "BMW M8", .price = 15000 },
    };

    struct Item houses_list[] = {
        { .item_name = "BEACH VILLA", .price = 250000 },
        { .item_name = "BIG APARTMENT", .price = 120000 },
        { .item_name = "STUDIO", .price = 60000 },
    };

    struct Business businesses_list[] = {
        { .item_name = "COPIER", .price = 7000, .turnover = 2500 },
        { .item_name = "TECH GIANT", .price = 200000, .turnover = 60000 },
        { .item_name = "ACCOUNTING FIRM", .price = 60000, .turnover = 15000 },
    };

    struct Item jobs_list[] = {
        { .item_name = "TRUCKER", .price = 0 },
        { .item_name = "FARMER", .price = 30 },
        { .item_name = "LUMBERJACK", .price = 50 },
        { .item_name = "MINER", .price = 70 },
        { .item_name = "DRUG DEALER", .price = 100 },
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
    void print_houses();
    void print_businesses();
    int buy_house(char* house_name);
    int buy_business(char* business_name);
    int check_business();
    int sell_business();
    int withdraw_business(int sum);
    int robbing();
    int rand50();
    bool rand25();
    bool rand50p();
    bool rand75();
%}

%start line
%union { int integer; char* string; }
%token play choose_character get job work see account_balance experience cars jobs businesses houses
%token property buy car house go_to casino dice bet leave rob party business check withdraw from quit sell invalid
%token <integer> value
%token <string> name


%%

line : play { printf("Welcome to GTA Simulator! Please select a character between: CJ or TREVOR or RYDER. Use 'I want to choose X' command.\n"); }
     | line choose_person { }
     | line leave { exit_game(); }
     | line job_topic { }
     | line car_topic { }
     | line house_topic { }
     | line business_topic { }
     | line casino_topic { }
     | line check_topic{ }
     | line party { go_to_party(); }
     | line invalid { }
     | line rob { robbing(); }
     | quit { printf("Thank you for playing!\n"); exit(0); }
     | /* NULL */;

job_topic   : get jobs { print_jobs(); }
            | get job name { get_new_job($3); }
            | work { work_job(); }

car_topic   : buy cars { print_cars(); }
            | buy car name { buy_car($3); }

house_topic : buy houses { print_houses(); }
            | buy house name { buy_house($3); }

business_topic: buy businesses { print_businesses(); }
              | buy business name { buy_business($3); }
              | check business { check_business(); }
              | withdraw from business value { withdraw_business($4); }
              | sell business { sell_business(); }

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
            my_wallet += 1000000;
            my_experience += 20;
        }
        else if (strcmp(character, "RYDER") == 0) {
            my_wallet += 10000;
            my_experience += 15;
        }
        else if (strcmp(character, "TREVOR") == 0) {
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
        printf("TRUCKER – 0 XP.\n");
        printf("FARMER – 30 XP.\n");
        printf("LUMBERJACK – 50 XP.\n");
        printf("MINER – 70 XP.\n");
        printf("DRUG DEALER – 100 XP.\n");
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

void see_wallet() {
    printf("Your wallet: %d$\n", my_wallet);
}

void see_my_property() {
   
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
        printf("Your business: %s, value is %d $\n", my_business.item_name, my_business.price);
    }
    if (my_property == 0) {
        printf("You don’t have any property!\n");
    }
}

void see_my_experience() {
    printf("Your experience: %d XP\n", my_experience);
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
        else if (strcmp(jobName, "LUMBERJACK") == 0) {
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
        else if (strcmp(jobName, "DRUG DEALER") == 0) {
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

        for(int i=0; i<5; i++){
            if(current_job != i){
                if(jobs_list[i].price <= my_experience && jobs_list[i].price >= jobs_list[current_job].price){
                   printf("New job available: %s. Change it with Get job %s\n", jobs_list[i].item_name, jobs_list[i].item_name);
                }
            }
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
    srand(time(0));
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
    srand(time(0));
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
    int ok = 0;
    for(int i=0; i<3; i++){
            if(strcmp(cars_list[i].item_name, car_name)==0){
                ok = 1;
                if(my_wallet >= cars_list[i].price){
                    my_wallet -= cars_list[i].price;
                    printf("You bought the %s car for %d\n", cars_list[i].item_name, cars_list[i].price);
                    my_cars[iter_cars++] = cars_list[i];
                }else{
                    printf("You do not have %d $! You only have %d $\n", cars_list[i].price, my_wallet);
                }
            }
            
        }

    if(!ok){
         printf("Car does not exist");
         return 0;
    }

    return 1;
}

void print_houses(){
    if (character_chosed == 1) {
        printf("Welcome to the car shop! To buy a car use “Buy car X” command. The available cars are:\n");
        for(int i=0; i<3; i++){
            printf("%s %d$\n", houses_list[i].item_name, houses_list[i].price);
        }
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

int buy_house(char* house_name){
    if(character_chosed == 0){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    if(iter_house == 1){
        printf("You already have a house!\n");
        return 0;
    }
    int ok = 0;
    for(int i=0; i<3; i++){
            if(strcmp(houses_list[i].item_name, house_name)==0){
                ok = 1;
                if(my_wallet >= houses_list[i].price){
                    my_wallet -= houses_list[i].price;
                    printf("You bought the %s for %d\n", houses_list[i].item_name, houses_list[i].price);
                    my_house = houses_list[i];
                    iter_house = 1;
                }else{
                    printf("You do not have %d $! You only have %d $\n", houses_list[i].price, my_wallet);
                }
            }
            
        }

    if(!ok){
         printf("House does not exist");
         return 0;
    }

    return 1;
}

void print_businesses(){
    if (character_chosed == 1) {
        printf("Welcome to the business market! To buy a business use “Buy business X” command. The available businesses are:\n");
        for(int i=0; i<3; i++){
            printf("%s %d$\n", businesses_list[i].item_name, businesses_list[i].price);
        }
    }
    else {
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
    }
}

int buy_business(char* business_name){
    if(character_chosed == 0){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    if(iter_business == 1){
        printf("You already have a business! Sell it in order to buy another!\n");
        return 0;
    }
    int ok = 0;
    for(int i=0; i<3; i++){
            if(strcmp(businesses_list[i].item_name, business_name)==0){
                ok = 1;
                if(my_wallet >= businesses_list[i].price){
                    my_wallet -= businesses_list[i].price;
                    printf("You bought the %s for %d\n", businesses_list[i].item_name, businesses_list[i].price);
                    my_business = businesses_list[i];
                    iter_business = 1;
                }else{
                    printf("You do not have %d $! You only have %d $\n", businesses_list[i].price, my_wallet);
                }
            }
            
        }

    if(!ok){
         printf("Business does not exist"); 
         return 0;
    }

    return 1;
}


int check_business(){
    srand(time(0));
    if(!choose_character){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    if(!iter_business){
        printf("You to buy a business first! Please use 'Buy business X' command.\n");
        return 0;
    }
    if(my_business.price == -1){
        printf("You do not have a business. You either sold it or lost it\n");
        return 0;
    }

    int money = rand() % my_business.turnover;
    int win_lose = 0;
    if(nr_good != 0){
        win_lose = rand() % nr_good * 3;
    }
     
    if(!nr_good){
        printf("Your business is thriving! Value increased by %d $\n", money);
        my_business.price += money;
        nr_good++;
    }
    else if(win_lose > nr_good){
        if(money > my_business.price){
            printf("Your business is in debt, you lose your business");
            my_business.price = -1;
            iter_business = 0;
        }
        else{
            printf("Your business is losing money! Value decreased by %d $\n", money);
            my_business.price -= money;
        }
       
    }else{
        printf("Your business is thriving! Value increased by %d $\n", money);
        my_business.price += money;
        nr_good++;
    }
    return 1;
}

int sell_business(){
     if(!choose_character){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    if(!iter_business){
        printf("You to buy a business first! Please use 'Buy business X' command.\n");
        return 0;
    }
    if(my_business.price == -1){
        printf("You do not have a business. You either sold it or lost it\n");
        return 0;
    }
     
     printf("Your business is sold, you inherit %d $\n", my_business.price);
     my_wallet += my_business.price;
     my_business.price = -1;
     iter_business = 0;
     return 1;
}

int withdraw_business(int sum){
    if(!choose_character){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    if(!iter_business){
        printf("You to buy a business first! Please use 'Buy business X' command.\n");
        return 0;
    }
    if(my_business.price == -1){
        printf("You do not have a business. You either sold it or lost it\n");
        return 0;
    }
    if(sum >= my_business.price){
        printf("Too little money in your business!\n");
        return 0;
    }

     my_wallet += sum; 
     my_business.price -= sum;
     printf("You withdrew %d $. Your business is now worth %d $.\n", sum, my_business.price);

     return 1;
}
int rand50(){
    return rand() & 1; 
}

bool rand75(){
    return rand50() | rand50();
}

bool rand50p(){
    return rand50() & rand50();
}

bool rand25(){
    return rand50() ^ rand50();
}



int robbing(){
    if(!my_experience){
        printf("You do not have any XP left. Work to gain and continue to rob!\n");
        return 0;
    }

    if(!choose_character){
        printf("You have to choose a character first! Please use 'I want to choose X' command.\n");
        return 0;
    }
    srand(time(NULL));
    int money_won = rand() % 20000;
    int xp_won = rand() % 20;
    int xp_lost = rand() % 30;

    if(my_experience < 30){
        if(rand25()){
            printf("You succesfully robbed the place! You get %d $ and %d XP.\n", money_won, xp_won);
            my_experience += xp_won;
            my_wallet += money_won;
            if(rand25()){
                struct Item stolen_car = { .item_name = "Robbed car", .price= 100000};
                my_cars[iter_cars++] = stolen_car;
                printf("You got lucky! While robbing you found a great car! It's been added to your property!\n");
            }
        }else{
            if(xp_lost > my_experience){
                printf("You were busted! You lose all your XP.\n");
                my_experience = 0;
                
            }else{
                printf("You were busted! You lose %d XP.\n", xp_lost);
                my_experience -= xp_lost;
            }
        }
    }else if(my_experience < 50){
        if(rand50p()){
            printf("You succesfully robbed the place! You get %d $ and %d XP.\n", money_won, xp_won);
            my_experience += xp_won;
            my_wallet += money_won;
            if(rand25()){
                struct Item stolen_car = { .item_name = "Robbed car", .price= 100000};
                my_cars[iter_cars++] = stolen_car;
                printf("You got lucky! While robbing you found a great car! It's been added to your property!\n");
            }
        }else{
           
            if(xp_lost > my_experience){
                printf("You were busted! You lose all your XP.\n");
                my_experience = 0;
            }else{
                printf("You were busted! You lose %d XP.\n", xp_lost);
                my_experience -= xp_lost;
            }
        }
    }else {
        if(rand75()){
            printf("You succesfully robbed the place! You get %d $ and %d XP.\n", money_won, xp_won);
            my_experience += xp_won;
            my_wallet += money_won;
            if(rand25()){
                struct Item stolen_car = { .item_name = "Robbed car", .price= 100000};
                my_cars[iter_cars++] = stolen_car;
                printf("You got lucky! While robbing you found a great car! It's been added to your property!\n");
            }
        }else{
            if(xp_lost > my_experience){
                printf("You were busted! You lose all your XP.\n");
                my_experience = 0;
            }else{
                printf("You were busted! You lose %d XP.\n", xp_lost);
                my_experience -= xp_lost;
            }
        }
    }
}


int main(void) {


    return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 