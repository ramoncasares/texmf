/* readtex.c (RMCG20051226) */

#include <stdio.h>

/* Interprets {\TeX}' "^^" notation.
   See ``The {\TeX}book'', pg 47.  */

/* States. How many '^' have been read */
#define NONE 0 
#define ONE 1 
#define TWO 2 
#define PASS 3 

int char2hex(int c){
 int i; i = -1;
 if      ( c == '0' ) i = 0;
 else if ( c == '1' ) i = 1;
 else if ( c == '2' ) i = 2;
 else if ( c == '3' ) i = 3; 
 else if ( c == '4' ) i = 4;
 else if ( c == '5' ) i = 5;
 else if ( c == '6' ) i = 6;
 else if ( c == '7' ) i = 7;
 else if ( c == '8' ) i = 8;
 else if ( c == '9' ) i = 9;
 else if ( c == 'a' ) i = 10;
 else if ( c == 'b' ) i = 11;
 else if ( c == 'c' ) i = 12;
 else if ( c == 'd' ) i = 13;
 else if ( c == 'e' ) i = 14;
 else if ( c == 'f' ) i = 15;          
 else i = -1;
 return i;
}

int main() {
 int b, c, state;
 state = NONE;
 b = 0; c = 0;
 while ((c = getchar()) != EOF) {
  if (state == NONE) {
   if (c == '^') state = ONE; else putchar(c);
  } else if (state == ONE) {
   if (c == '^') state = TWO; else putchar(c);
  } else if (state == TWO) {
   if (c > 127) {
    putchar('^'); putchar('^'); putchar(c);
    state = NONE;
   }
   else {
    b = c;
    state = PASS;
   }
  } else if (state == PASS) {
   if ( char2hex(b) > -1 && char2hex(c) > -1 ) {
    putchar( char2hex(b) * 16 + char2hex(c) );
    state = NONE; 
   } 
   else {
    if (b < 64) putchar(b+64); else putchar(b-64);
    if (c == '^') state = ONE; else { putchar(c); state = NONE; } 
   }  
  }
 }
 if      (state == ONE) { putchar('^'); }
 else if (state == TWO) { putchar('^'); putchar('^'); }
 else if (state == PASS) {
  if (b < 64) putchar(b+64); else putchar(b-64);
 }
 return 0;
}
