#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LSIZE 150
#define RSIZE 150

int main(void) {
  char line[RSIZE][LSIZE];
  char grid[RSIZE][LSIZE];
  FILE *fptr = NULL;
  int i = 0;

  // read file
  fptr = fopen("input.txt", "r");
  while (fgets(line[i], LSIZE, fptr)) {
    line[i][strlen(line[i]) - 1] = '\0';
    i++;
  }

  // make a grid to store starting index of integers found
  for (int i = 0; i < LSIZE - 2; i++) {
    for (int j = 0; j < RSIZE - 2; j++) {
      grid[i][j] = '.';
    }
  }

  for (int i = 0; i < RSIZE; i++) {
    int length = (int)strlen(line[i]);
    for (int j = 0; j < length; j++) {
      // find symbols
      if (line[i][j] != '.' && isdigit(line[i][j]) == 0) {
        for (int r = i - 1; r <= i + 1; r++) {
          for (int c = j - 1; c <= j + 1; c++) {
            if (r >= 0 || r < RSIZE || c >= 0 || c < LSIZE) {
              if (isdigit(line[r][c]) != 0) {
                int cc = c;
                while (cc > 0 && isdigit(line[r][cc - 1]) != 0) {
                  cc--;
                }
                // store starting index of integer that has symbol adjacent
                grid[r][cc] = '*';
              }
            }
          }
        }
      }
    }
  }

  int total = 0;

  // loop through result grid to gather integers
  for (int i = 0; i < LSIZE - 2; i++) {
    for (int j = 0; j < RSIZE - 2; j++) {
      if (grid[i][j] == '*') { // found start
        int x = j;
        char str[5] = "";
        // gather and concat full integer
        while (x < RSIZE && isdigit(line[i][x]) != 0) {
          char v[1];
          v[0] = line[i][x];
          strncat(str, v, 1);
          x++;
        }
        int r = atoi(str);
        total += r;
      }
    }
  }
  printf("%i\n", total);

  return 0;
}
