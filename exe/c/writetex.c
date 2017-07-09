/* writetex.c (RMCG20051226) */

#include <stdio.h>

int int2hex(int i){
 int c; c = '?';
 if      ( i == 0 )  c = '0';
 else if ( i == 1 )  c = '1';
 else if ( i == 2 )  c = '2';
 else if ( i == 3 )  c = '3'; 
 else if ( i == 4 )  c = '4';
 else if ( i == 5 )  c = '5';
 else if ( i == 6 )  c = '6';
 else if ( i == 7 )  c = '7';
 else if ( i == 8 )  c = '8';
 else if ( i == 9 )  c = '9';
 else if ( i == 10 ) c = 'a';
 else if ( i == 11 ) c = 'b';
 else if ( i == 12 ) c = 'c';
 else if ( i == 13 ) c = 'd';
 else if ( i == 14 ) c = 'e';
 else if ( i == 15 ) c = 'f';          
 else c = '?';
 return c;
}

int main() {
 int c; c = 0;
 while ((c = getchar()) != EOF) {
  if ( c > 31 && c < 127 ) {
   putchar(c);
  } else {
   putchar('^'); putchar('^');
   putchar( int2hex( c / 16 ) );
   putchar( int2hex( c % 16 ) );
  
  }
 }
 return 0;
} 

