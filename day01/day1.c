#include <stdio.h>
#include <stdlib.h>

int main() {
  FILE *infile;
  char buf[6];
  int lines;

  // count num of lines in file to alloc correct size of array
  infile = fopen("./input", "r");
  for (lines = 0; fgets(buf, sizeof(buf), infile) != NULL; lines++) {
  }

  // now that we know now many numbers are in the input file,
  // allocate the array at the correct size
  int *input = malloc(sizeof(int) * lines);

  // read in the file again and parse numbers into the array
  fseek(infile, 0, SEEK_SET);
  for (int i = 0; fgets(buf, sizeof(buf), infile) != NULL; i++) {
    input[i] = atoi(buf);
  }
  fclose(infile);

  int found2sum = 0;
  int found3sum = 0;

  for (int i = 0; i < lines; i++) {
    for (int j = 0; j < lines; j++) {
      if (input[i] + input[j] == 2020 && !found2sum) {
        printf("Two-number sum: %i\n", input[i] * input[j]);
        found2sum = 1;
      }

      for (int k = 0; k < lines; k++) {
        if (input[i] + input[j] + input[k] == 2020 && !found3sum) {
          printf("Three-number sum: %i\n", input[i] * input[j] * input[k]);
          found3sum = 1;
        }
      }
    }
  }

  free(input);
}
