#include "s21_grep.h"

int main(int argc, char *argv[]) {
  int pat_ind = 0;
  regex_t preg_storage;
  regex_t *preg = &preg_storage;
  char *reg_pattern = NULL;
  int fail = 0;
  Flags flags = get_flag(argc, argv, &pat_ind, &reg_pattern, &fail);
  int file_count = 0;
  if (flags.flag_e || flags.flag_f) {
    if (regcomp(preg, reg_pattern, flags.flag_regex)) {
      free(reg_pattern);
      regfree(preg);
      printf("Regex compile error");
      exit(1);
    }
    pat_ind--;
  } else {
    if (regcomp(preg, argv[pat_ind], flags.flag_regex)) {
      free(reg_pattern);
      regfree(preg);
      printf("Regex compile error");
      exit(1);
    }
  }
  file_count = argc - pat_ind - 1;
  for (int i = pat_ind + 1; i < argc; i++) {
    if (flags.flag_l) {
      grep_filematch(argv[i], flags, preg);
    } else {
      if (flags.flag_c) {
        grep_count(argv[i], flags, preg, file_count);
      } else {
        s21_grep(argv[i], flags, preg, file_count);
      }
    }
  }
  free(reg_pattern);
  regfree(preg);
  return 0;
}
