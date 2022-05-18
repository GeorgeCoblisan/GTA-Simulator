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
    get = 260,
    job = 261,
    work = 262,
    see = 263,
    account_balance = 264,
    experience = 265,
    property = 266,
    buy = 267,
    car = 268,
    house = 269,
    go_to = 270,
    casino = 271,
    dice = 272,
    bet = 273,
    leave = 274,
    rob = 275,
    party = 276,
    business = 277,
    check = 278,
    withdraw = 279,
    from = 280,
    quit = 281,
    sell = 282,
    invalid = 283,
    value = 284,
    name = 285
  };
#endif
/* Tokens.  */
#define play 258
#define choose_character 259
#define get 260
#define job 261
#define work 262
#define see 263
#define account_balance 264
#define experience 265
#define property 266
#define buy 267
#define car 268
#define house 269
#define go_to 270
#define casino 271
#define dice 272
#define bet 273
#define leave 274
#define rob 275
#define party 276
#define business 277
#define check 278
#define withdraw 279
#define from 280
#define quit 281
#define sell 282
#define invalid 283
#define value 284
#define name 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 53 "yacc.y"
 int integer; char* string; 

#line 120 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
