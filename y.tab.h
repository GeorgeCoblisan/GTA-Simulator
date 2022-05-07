/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    play = 258,
    choose_character = 259,
    list_job = 260,
    get_job = 261,
    work = 262,
    account_balance = 263,
    experience = 264,
    property = 265,
    list_car = 266,
    get_car = 267,
    list_house = 268,
    get_house = 269,
    list_casino = 270,
    dice = 271,
    bet = 272,
    exit_casino = 273,
    rob = 274,
    party = 275,
    list_business = 276,
    business = 277,
    check_business = 278,
    withdraw = 279,
    from_business = 280,
    quit = 281,
    sell_business = 282,
    value = 283,
    name = 284
  };
#endif
/* Tokens.  */
#define play 258
#define choose_character 259
#define list_job 260
#define get_job 261
#define work 262
#define account_balance 263
#define experience 264
#define property 265
#define list_car 266
#define get_car 267
#define list_house 268
#define get_house 269
#define list_casino 270
#define dice 271
#define bet 272
#define exit_casino 273
#define rob 274
#define party 275
#define list_business 276
#define business 277
#define check_business 278
#define withdraw 279
#define from_business 280
#define quit 281
#define sell_business 282
#define value 283
#define name 284

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 25 "yacc.y"
 int integer; char* string; 

#line 118 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
