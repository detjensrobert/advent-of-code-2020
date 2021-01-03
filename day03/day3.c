#include <bits/thread-shared-types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long calc_trees(char **slope, int s_width, int s_length, int x_inc, int y_inc) {
  int x = 0;
  int y = 0;

  long trees_encountered = 0;

  while (x < s_length - 1) {
    x += x_inc;
    y += y_inc;

    if (slope[x][y % s_width] == '#') {
      trees_encountered++;
    }
  }

  return trees_encountered;
}

int main() {
  FILE *infile = fopen("./input", "r");

  char buf[50];

  char **slope = malloc(sizeof(char *) * 1);

  int s_width = 0;
  int s_length = 0;

  int i = 0;
  while (!feof(infile)) {
    fgets(buf, sizeof(buf), infile);

    // last real `gets` doesnt trigger EOF
    // break here so buf gets copied twice
    if (feof(infile)) {
      break;
    }

    // remove captured newline
    if (buf[strlen(buf) - 1] == '\n') {
      buf[strlen(buf) - 1] = '\0';
    }
    s_width = strlen(buf);

    // expand outer array as we go
    slope = realloc(slope, sizeof(char *) * ++s_length);
    slope[i] = malloc(sizeof(char) * s_width);

    strncpy(slope[i], buf, strlen(buf));

    i++;
  }
  fclose(infile);

  // == Part 1 ==
  // Find how many trees (#) are encountered when moving down 1 and right 3
  // through the input.

  printf("Trees encountered: %li\n", calc_trees(slope, s_width, s_length, 1, 3));

  // == Part 2 ==
  // Find the product of the above for the following slopes:
  // - Right 1, down 1.
  // - Right 3, down 1.
  // - Right 5, down 1.
  // - Right 7, down 1.
  // - Right 1, down 2.

  long total = calc_trees(slope, s_width, s_length, 1, 1) *
              calc_trees(slope, s_width, s_length, 1, 3) *
              calc_trees(slope, s_width, s_length, 1, 5) *
              calc_trees(slope, s_width, s_length, 1, 7) *
              calc_trees(slope, s_width, s_length, 2, 1);
  printf("Total product of all paths: %li\n", total);

  for (int i = 0; i < s_length; i++) {
    free(slope[i]);
  }
  free(slope);
}
