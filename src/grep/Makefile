TARGET=s21_grep
CC=gcc -Wall -Wextra -Werror -std=c11

all : s21_grep

s21_grep :
	@$(CC) s21_grep.c s21_grep_func.c -o $(TARGET)

debug :
	@$(CC) -g s21_grep.c s21_grep_func.c -o $(TARGET)

clean :
	@rm -rf $(TARGET)

rebuild : clean all
