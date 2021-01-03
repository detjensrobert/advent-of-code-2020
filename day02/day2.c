#include <stdio.h>
#include <stdlib.h>

int str_count(char *str, char target) {
  int count = 0;
  for (int i = 0; str[i]; i++) {
    count += (str[i] == target);
  }
  return count;
}

int main() {
  FILE *infile = fopen("./input", "r");

  int x;
  int y;
  char c;
  char str[30];

  // == Part 1 ==
  // Find all lines where `str` does not contain `c` between `x` and `y` times
  int valid_ranges = 0;

  // == Part 2 ==
  // Find all lines where `str` contains `c` at either position `X` or `Y`
  int valid_positionals = 0;

  while (fscanf(infile, "%d-%d %c: %s", &x, &y, &c, str) != EOF) {
    int count = str_count(str, c);
    if (count >= x && count <= y) {
      valid_ranges++;
    }

    if ((str[x - 1] == c) ^ (str[y - 1] == c)) {
      valid_positionals++;
    }
  }

  printf("Valid passwords for range: %i\n", valid_ranges);
  printf("Valid passwords for positions: %i\n", valid_positionals);

  fclose(infile);
}
