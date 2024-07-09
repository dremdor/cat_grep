#ifndef S21_GREP_H
#define S21_GREP_H

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int flag_e;
  int flag_regex;
  int flag_v;
  int flag_c;
  int flag_l;
  int flag_n;
  int flag_h;
  int flag_s;
  int flag_f;
  int flag_o;
} Flags;
void complete_pattern(char **reg_pattern, char *new_patt, int *fail);
void patt_from_file(char *file_name, char **reg_pattern, int *fail);
Flags get_flag(int argc, char *argv[], int *pat_ind, char **reg_pattern,
               int *fail);
void s21_grep(char *file_name, Flags flags, regex_t *preg, int file_count);
void grep_count(char *file_name, Flags flags, regex_t *preg, int file_count);
void grep(char *buffer, Flags flags, regex_t *preg, int count_lines,
          int file_count, char *file_name);
void grep_invert(char *buffer, regex_t *preg, Flags flags, int file_count,
                 char *file_name, int count_lines);
void grep_filematch(char *file_name, Flags flags, regex_t *preg);

#endif
