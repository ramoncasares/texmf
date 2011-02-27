/* firstindex.c (RMCG20051226) */

#include <stdio.h>
#include <string.h>
#include <regex.h>

/* Creates a first ndx file from a ind file. */

/* 1) First, readtex should be executed on the ind file,
      to eliminate any "^^".
   2) Then, the resulting file should be sorted. 
   3) And finally, firstindex can be executed
      on the sorted file to produce a first ndx file.
      It groups entries,
      independent of the first letter capitalitation,
      and of number (singular or plural).
*/

#define BUFFERLENGTH 1024   /* buffer size for strings */
regex_t pattern;            /* the compiled pattern */ 
char current[BUFFERLENGTH]; /* buffer containing the current word */

int isvowel(int c){
 int i = 0;
 if      ( c == 'a' || c == 'A' ) i = 1;
 else if ( c == 'e' || c == 'E' ) i = 2;
 else if ( c == 'i' || c == 'I' ) i = 3;
 else if ( c == 'o' || c == 'O' ) i = 4;
 else if ( c == 'u' || c == 'U' ) i = 5;
 else if ( c == 'á' || c == 'Á' ) i = 11;
 else if ( c == 'é' || c == 'É' ) i = 12;
 else if ( c == 'í' || c == 'Í' ) i = 13;
 else if ( c == 'ó' || c == 'Ó' ) i = 14;
 else if ( c == 'ú' || c == 'Ú' ) i = 15;
 else if ( c == 'ü' || c == 'Ü' ) i = 25;
 else i = 0;
 return i;
}

size_t buildNewEntry(char *entry) {
 char cp[BUFFERLENGTH];
 char last[BUFFERLENGTH];
 strcpy( cp , entry ); /* Make a writable copy. */
 size_t l = strlen(cp);
 if ( l < 1 ) return 1;
 int i = 0;
 /* First the starting mark */
 last[i++] = '^'; putchar('^');
 /* We take care of the first character */
 char c1 = cp[0];
 if ( isalpha(c1) ) {
  last[i++] = '['; putchar('['); 
  last[i++] = toupper(c1); putchar(toupper(c1)); 
  last[i++] = tolower(c1); putchar(tolower(c1));
  last[i++] = ']'; putchar(']');
 } else { last[i++] = c1; putchar(c1); }
 /* Then we just copy the middle */
 int j;
 for (j=1; j<l; ++j) { last[i++] = entry[j]; putchar(entry[j]); }
 /* And finally, we take care of the last character */ 
 char cl = cp[l-1];
 if ( isvowel(cl) ) {
  last[i++] = '('; last[i++] = 's'; last[i++] = ')'; last[i++] = '?'; 
  fputs("(s)?",  stdout);  
 } else {
   last[i++] = '('; last[i++] = 'e'; last[i++] = 's'; last[i++] = ')';
   last[i++] = '?'; 
   fputs("(es)?", stdout);
 }
 /* and the TeX end of arg */
 last[i++] = '\\'; last[i++] = '}'; fputs("\\}", stdout);
 last[i++] = '\0';
 /* Lastly, compile the pattern */
 size_t rm;
 regfree(&pattern);
 if ((rm = regcomp (&pattern, last, REG_EXTENDED)) != 0)  
  fprintf(stderr,"Invalid expression:'%s'\n",last);
 return rm; 
} 

/* \ndxline{filósofo}{1}{0010}{2}{8}        */
/* \ndxentry/^[Ff]ilósofo(s)?\}/filósofo/1/ */

main() {
 regcomp (&pattern, "zZz", REG_EXTENDED); 
 char level[BUFFERLENGTH];
 char text[BUFFERLENGTH];
 const char delimiters[] = "{}";
 char p[BUFFERLENGTH];
 char cp[BUFFERLENGTH]; 
 while (fgets(p,BUFFERLENGTH,stdin) != NULL ) {
  strcpy ( cp , p ); /* Make writable copy.  */
  //fprintf(stderr, "cp: %s", cp);  
  //strcpy( token , strtok(cp, delimiters) );
  strtok(cp, delimiters);
  //fprintf(stderr, "token: %s\n", token);
  strcpy( current , strtok(NULL, delimiters) );
  //fprintf(stderr, "current: %s\n", current);
  strcpy( level , strtok(NULL, delimiters) );
  //fprintf(stderr, "level: %s\n", level);
  strcpy(text, current); strcat(text, "}{"); strcat(text, level); 
  //fprintf(stderr, "text: %s\n", text);
  if ( regexec(&pattern, text, 0, NULL, 0) ) {
   fputs("\\ndxentry/", stdout);
   buildNewEntry(current);
   fputs("/", stdout);
   fputs(current, stdout);
   fputs("/", stdout);
   fputs(level, stdout);
   fputs("/\n", stdout);
  }
 }
 return 0;  
}
