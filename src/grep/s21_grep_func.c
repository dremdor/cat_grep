#define _GNU_SOURCE
#include "s21_grep.h"

void complete_pattern(char **reg_pattern, char *new_patt, int *fail) {
  size_t new_size = (*reg_pattern != NULL) ? strlen(*reg_pattern) : 0;
  new_size += strlen(new_patt) + 3;
  char *resized_reg_pattern = realloc(*reg_pattern, new_size);
  if (resized_reg_pattern == NULL) {
    *fail = 1;
    free(*reg_pattern);
    exit(1);
  } else {
    if (*reg_pattern != NULL && **reg_pattern != '\0') {
      strcat(resized_reg_pattern, "|");
    } else {
      resized_reg_pattern[0] = '\0';
    }
    strcat(resized_reg_pattern, new_patt);
    *reg_pattern = resized_reg_pattern;
  }
}

Flags get_flag(int argc, char *argv[], int *pat_ind, char **reg_pattern,
               int *fail) {
  int input;
  Flags flags = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  while ((input = getopt(argc, argv, "e:ivclnhsf:o")) != -1) {
    switch (input) {
      case 'e':
        flags.flag_e = 1;
        flags.flag_regex |= REG_EXTENDED;
        complete_pattern(reg_pattern, optarg, fail);
        if (*fail) {
          free(reg_pattern);
          printf("complete pattern error");
          exit(1);
        }
        break;
      case 'i':
        flags.flag_regex |= REG_ICASE;
        break;
      case 'v':
        flags.flag_v = 1;
        break;
      case 'c':
        flags.flag_c = 1;
        break;
      case 'l':
        flags.flag_l = 1;
        break;
      case 'n':
        flags.flag_n = 1;
        break;
      case 'h':
        flags.flag_h = 1;
        break;
      case 's':
        flags.flag_s = 1;
        break;
      case 'f':
        flags.flag_f = 1;
        flags.flag_regex |= REG_EXTENDED;
        patt_from_file(optarg, reg_pattern, fail);
        if (*fail) {
          free(reg_pattern);
          printf("complete pattern error");
          exit(1);
        }
        break;
      case 'o':
        flags.flag_o = 1;
        break;
      default:
        free(reg_pattern);
        printf("Flags error");
        exit(1);
    }
  }
  if (optind >= argc) {
    free(reg_pattern);
    printf("No file error");
    exit(1);
  }
  *pat_ind = optind;
  return flags;
}

void s21_grep(char *file_name, Flags flags, regex_t *preg, int file_count) {
  FILE *fp;
  fp = fopen(file_name, "r");
  if (fp == NULL) exit(1);
  char *buffer = NULL;
  size_t len = 0;
  int count_lines = 1;
  while (getline(&buffer, &len, fp) != -1) {
    if (flags.flag_v) {
      if (flags.flag_o) continue;
      grep_invert(buffer, preg, flags, file_count, file_name, count_lines);
    } else {
      grep(buffer, flags, preg, count_lines, file_count, file_name);
    }
    count_lines++;
  }
  free(buffer);
  fclose(fp);
}

void grep_filematch(char *file_name, Flags flags, regex_t *preg) {
  (void)flags;
  FILE *fp;
  fp = fopen(file_name, "r");
  if (fp == NULL) exit(1);
  char *buffer = NULL;
  size_t len = 0;
  regmatch_t match;
  while (getline(&buffer, &len, fp) != -1) {
    if (!regexec(preg, buffer, 1, &match, 0)) {
      printf("%s\n", file_name);
      break;
    }
  }
  free(buffer);
  fclose(fp);
}

void grep_invert(char *buffer, regex_t *preg, Flags flags, int file_count,
                 char *file_name, int count_lines) {
  if (regexec(preg, buffer, 0, NULL, 0) != 0) {
    if (flags.flag_n) printf("%d:", count_lines);
    if (!flags.flag_h && file_count > 1) printf("%s:", file_name);
    printf("%s", buffer);
    if (buffer[strlen(buffer) - 1] != '\n') printf("\n");
  }
}

void grep(char *buffer, Flags flags, regex_t *preg, int count_lines,
          int file_count, char *file_name) {
  regmatch_t match;
  if (!regexec(preg, buffer, 1, &match, 0)) {
    if (flags.flag_o) {
      if (!flags.flag_h && file_count > 1) printf("%s:", file_name);
      printf("%.*s\n", (int)(match.rm_eo - match.rm_so), buffer + match.rm_so);
      char *remain = buffer + match.rm_eo;
      while (!regexec(preg, remain, 1, &match, 0)) {
        if (!flags.flag_h && file_count > 1) printf("%s:", file_name);
        printf("%.*s\n", (int)(match.rm_eo - match.rm_so),
               remain + match.rm_so);
        remain += match.rm_eo;
      }
    } else {
      if (!flags.flag_h && file_count > 1) printf("%s:", file_name);
      if (flags.flag_n) printf("%d:", count_lines);
      printf("%s", buffer);
    }
  }
}

void grep_count(char *file_name, Flags flags, regex_t *preg, int file_count) {
  FILE *fp;
  fp = fopen(file_name, "r");
  if (fp == NULL) exit(1);
  char *buffer = NULL;
  size_t len = 0;
  regmatch_t match;
  int count = 0;
  while (getline(&buffer, &len, fp) != -1) {
    if (!flags.flag_v) {
      if (!regexec(preg, buffer, 1, &match, 0)) {
        count++;
      }
    } else {
      if (regexec(preg, buffer, 1, &match, 0)) {
        count++;
      }
    }
  }
  if (!flags.flag_h && file_count > 1) printf("%s:", file_name);
  printf("%d\n", count);
  free(buffer);
  fclose(fp);
}

void patt_from_file(char *file_name, char **reg_pattern, int *fail) {
  FILE *fp;
  fp = fopen(file_name, "r");
  if (fp == NULL) exit(1);
  size_t len = 0;
  char *buffer = NULL;
  while (getline(&buffer, &len, fp) != -1) {
    buffer[strcspn(buffer, "\n")] = '\0';
    complete_pattern(reg_pattern, buffer, fail);
    if (*fail) {
      free(buffer);
      fclose(fp);
      exit(1);
    }
  }
  free(buffer);
  fclose(fp);
}
