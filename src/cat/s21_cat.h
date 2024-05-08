#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NO_FLAG 1
#define FLAG_B 2
#define FLAG_E 3
#define FLAG_N 4
#define FLAG_S 5
#define FLAG_T 6

typedef struct {
  int flag_b;
  int flag_e;
  int flag_n;
  int flag_s;
  int flag_t;
  int flag_v;
} Flags;

void s21_cat(char *file_name, Flags flags);

void flag_b(const char *ch, int *number, int *count);
void flag_e(const char *ch);
void flag_n(const char *ch, int *number, int *count);
void flag_s(const char *ch, int *is_newline);
Flags get_flag(int argc, char *argv[], int *files);
void flag_t(char *ch);
void flag_v(char *ch);
#endif
