#include "s21_cat.h"

int main(int argc, char **argv) {
  int files;
  Flags flags = get_flag(argc, argv, &files);
  for (int i = files; i < argc; i++) {
    s21_cat(argv[i], flags);
  }
  return 0;
}
