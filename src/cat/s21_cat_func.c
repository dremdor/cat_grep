#define _GNU_SOURCE
#include "s21_cat.h"

Flags get_flag(int argc, char *argv[], int *files) {
  struct option gnuOptions[] = {{"number-nonblank", 0, NULL, 'b'},
                                {"number", 0, NULL, 'n'},
                                {"squeeze-blank", 0, NULL, 's'},
                                {NULL, 0, NULL, 0}};
  int input;
  Flags flags = {0, 0, 0, 0, 0, 0};
  while ((input = getopt_long(argc, argv, "benstvET", gnuOptions, NULL)) !=
         -1) {
    switch (input) {
      case 'b':
        flags.flag_b = 1;
        flags.flag_n = 0;
        break;
      case 'e':
        flags.flag_v = 1;
        flags.flag_e = 1;
        //
        break;
      case 'n':
        if (!flags.flag_b) flags.flag_n = 1;
        //
        break;
      case 's':
        flags.flag_s = 1;
        //
        break;
      case 't':
        flags.flag_v = 1;
        flags.flag_t = 1;
        //
        break;
      case 'v':
        flags.flag_v = 1;
        //
        break;
      case 'E':
        flags.flag_e = 1;
        //
        break;
      case 'T':
        flags.flag_t = 1;
        //
        break;
    }
  }
  *files = optind;
  return flags;
}

void s21_cat(char *file_name, Flags flags) {
  FILE *fp;
  fp = fopen(file_name, "r");
  if (fp == NULL) {
    printf("File error\n");
    exit(1);
  }
  char ch;
  int number = 1, count = 1;
  int is_newline = 0;
  while ((ch = fgetc(fp)) != EOF) {
    if (flags.flag_b) flag_b(&ch, &number, &count);
    if (flags.flag_e) flag_e(&ch);
    if (flags.flag_n) flag_n(&ch, &number, &count);
    if (flags.flag_s) flag_s(&ch, &is_newline);
    if (flags.flag_t) flag_t(&ch);
    if (flags.flag_v) flag_v(&ch);
    if (!flags.flag_s) printf("%c", ch);
  }
  fclose(fp);
}

void flag_n(const char *ch, int *number, int *count) {
  if (*number == 1) {
    printf("%6d\t", *count);
    (*count)++;
    *number = 0;
  }
  if (*ch == '\n' && *number != 1) *number = 1;
}

void flag_b(const char *ch, int *number, int *count) {
  if (*number == 1 && *ch != '\n') {
    printf("%6d\t", *count);
    (*count)++;
    *number = 0;
  } else if (*ch == '\n' && *number == 0)
    *number = 1;
  if (*ch == '\n' && *number != 1) *number = 1;
}

void flag_s(const char *ch, int *is_newline) {
  if (*ch == '\n' && *is_newline < 2) {
    (*is_newline)++;
    printf("%c", *ch);
  } else if (*ch != '\n') {
    *is_newline = 0;
    printf("%c", *ch);
  }
}

void flag_e(const char *ch) {
  if (*ch == '\n') printf("$");
}

void flag_t(char *ch) {
  if (*ch == '\t') {
    printf("^");
    *ch = 'I';
  }
}

void flag_v(char *ch) {
  if (*ch != '\n' && *ch != '\t') {
    if (*ch > 126) {
      *ch -= 128;
      if (*ch >= 0) printf("M-");
    }
    if (*ch < 32 || *ch == 127) {
      printf("^");
    }
    if (*ch < 32) *ch += 64;
  }
}
