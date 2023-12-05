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

  struct entry {
    int x;
    int y;
  };

  struct entry entries[10000];
  int entry_count = 0;

  // read file
  fptr = fopen("input.txt", "r");
  while (fgets(line[i], LSIZE, fptr)) {
    line[i][strlen(line[i]) - 1] = '\0';
    i++;
  }

  for (int i = 0; i < RSIZE; i++) {
    int length = (int)strlen(line[i]);
    for (int j = 0; j < length; j++) {
      int last_r = 0;
      int last_c = 0;
      // find symbols
      int num = 0;
      if (line[i][j] == '*') {
        // printf("star: %i:%i\n", i, j);
        for (int r = i - 1; r <= i + 1; r++) {
          for (int c = j - 1; c <= j + 1; c++) {
            if (r >= 0 || r < RSIZE || c >= 0 || c < LSIZE) {
              if (isdigit(line[r][c]) != 0) {
                int cc = c;
                while (cc > 0 && isdigit(line[r][cc - 1]) != 0) {
                  cc--;
                }
                // printf("%i:%i %c\n", r, cc, line[r][c]);
                // store starting index of integer that has symbol adjacent
                if (entry_count == 0) {
                  entries[entry_count].x = r;
                  entries[entry_count].y = cc;
                  num++;
                  entry_count++;
                  // printf("entry: %i:%i %c\n", r, cc, line[r][cc]);
                } else if (entries[entry_count - 1].y != cc ||
                           entries[entry_count - 1].x != r) {
                  entries[entry_count].x = r;
                  entries[entry_count].y = cc;
                  num++;
                  entry_count++;
                  //printf("entry: %i %i:%i %c\n", num, r, cc, line[r][cc]);
                }
              }
            }
          }
        }
        if (num != 2) {
          // printf("removing entry at %i ", entry_count);
          entries[entry_count - 1].x = -1;
        }
      }
    }
  }

  int total = 0;
  int count = 0;
  int val = 1;
  // loop through result grid to gather integers
  for (int i = 0; i < entry_count; i++) {

    if (count >= 2) {
      count = 0;
      val = 1;
    }

    if (entries[i].x >= 0) { // found start
      // printf("entry count: %i", i);
      int x = entries[i].x;
      int y = entries[i].y;
      char str[5] = "";
      // gather and concat full integer
      while (x < RSIZE && isdigit(line[x][y]) != 0) {
        char v[1];
        v[0] = line[x][y];
        strncat(str, v, 1);
        y++;
      }
      int r = atoi(str);
      count++;
      if (count <= 2) {
        // printf("val*r: %i * %i ", val,r);
        val *= r;
        // printf("val: %i ", val);
      }
      if (count == 2) {
        total += val;
        // printf("total: %i\n", total);
      }
    }
  }
  printf("%i\n", total);
  // printf("%i\n", entry_count);
  return 0;
}
