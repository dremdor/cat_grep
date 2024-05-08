TARGET=s21_cat
CC=gcc -Wall -Wextra -Werror -std=c11

all : s21_cat

s21_cat : 
	@$(CC) s21_cat.c s21_cat_func.c -o $(TARGET)

debug :
	@$(CC) -g s21_cat.c s21_cat_func.c -o $(TARGET)

clean :
	@rm -rf $(TARGET)

rebuild : clean all
