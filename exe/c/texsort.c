/* TeXSORT.C (RMCG19980325) */

#include <stdio.h>
#include <stdlib.h>
/* #include <ctype.h> */

#define BUFFERLENGTH 131072  /* buffer size */
#define MAXLINES 8192        /* max #lines to be sorted */

char buffer[BUFFERLENGTH];   /* buffer containing input */
char *line[MAXLINES];        /* pointers to text lines */

/* BEGIN ctype replacement */

/* NOTE: isdigit('é') returns no zero */
/* NOTE: isspace('é') returns no zero */

int islower(int c){if (c >= 'a' && c <= 'z') return c; else return 0;}
int isupper(int c){if (c >= 'A' && c <= 'Z') return c; else return 0;}
int isdigit(int c){if (c >= '0' && c <= '9') return c; else return 0;}
int isspace(int c){
 if ( c == ' ' ||
      c == '\f' ||
      c == '\n' ||
      c == '\r' ||
      c == '\t' ||
      c == '\v' )
  return 32;
 else return 0;}
int tolower(int c){
 if ( c >= 'A' && c <= 'Z' ) return c - 'A' + 'a'; else return c;}

/* END ctype replacement */

/* Sorts input lines */

int charval(char c){
 if (c == '\0') return -1;
 else if (islower(c)) return c;
 else if (isupper(c)) return tolower(c);
 else if (isdigit(c)) return c;
 else if (isspace(c)) return 32;
 else if (c == 'á') return 'a';
 else if (c == 'Á') return 'a';
 else if (c == 'é') return 'e';
 else if (c == 'É') return 'e';
 else if (c == 'í') return 'i';
 else if (c == 'Í') return 'i';
 else if (c == 'ó') return 'o';
 else if (c == 'Ó') return 'o';
 else if (c == 'ö') return 'o';
 else if (c == 'Ö') return 'o';
 else if (c == 'ú') return 'u';
 else if (c == 'Ú') return 'u';
 else if (c == 'ü') return 'u';
 else if (c == 'Ü') return 'u';
 else if (c == 'ñ') return 'n';
 else if (c == 'Ñ') return 'n';
 else if (c == '{' || c == '}') return 31;
 else return 0;
}

int lstrcmp(char *s, char *t) {
 while (!charval(*s)) s++; while (!charval(*t)) t++;
 while (charval(*s) == charval(*t)) {
  if (*s == '\0') return 0;
  s++; while (!charval(*s)) s++;
  t++; while (!charval(*t)) t++;
 }
 return charval(*s) - charval(*t);
}

int pstrcmp(char **ps, char **pt) {return lstrcmp(*ps,*pt);}

main() {
 int n, nl;
 char *p;
 p = buffer; nl = 0;
 while (gets(p) != NULL) {
  line[nl++] = p; while (*p) p++; p++;
  if (nl == MAXLINES) {
   fprintf(stderr, "%s\n", "Demasiadas líneas"); return -1; }
  if (p >= buffer + BUFFERLENGTH) {
   fprintf(stderr, "%s\n", "Fichero demasiado largo"); return -2; }
 }
 qsort((void *) line, (size_t) nl, sizeof(char *),
  (int (*) (const void*, const void*)) pstrcmp);
 n = 0; while (nl-- > 0) puts(line[n++]);
 return 0;
}
