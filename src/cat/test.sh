#!/bin/bash

#no flag
A="file.txt"
B="result.txt"

make clean
make debug

rm -rf "$B"

echo "Test no flag" >> "$B"
cat "$A" > 1 && ./s21_cat "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -b" >> "$B"
cat -b "$A" > 1 && ./s21_cat -b "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -b "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag (GNU: --number-nonblank)" >> "$B"
cat --number-nonblank "$A" > 1 && ./s21_cat --number-nonblank "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat --number-nonblank

echo "---------------------------------------------------" >> "$B"

echo "Test flag -e" >> "$B"
cat -e "$A" > 1 && ./s21_cat -e "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -e "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -n" >> "$B"
cat -n "$A" > 1 && ./s21_cat -n "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -n "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag (GNU: --number)" >> "$B"
cat --number "$A" > 1 && ./s21_cat --number "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat --number "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -s" >> "$B"
cat -s "$A" > 1 && ./s21_cat -s "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -s "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag (GNU: --squeeze-blank)" >> "$B"
cat --squeeze-blank "$A" > 1 && ./s21_cat --squeeze-blank "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat --squeeze-blank "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -t" >> "$B"
cat -t "$A" > 1 && ./s21_cat -t "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -t "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -v" >> "$B"
cat -v "$A" > 1 && ./s21_cat -v "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -v "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test multiply files" >> "$B"
cat "$A" "$A" > 1 && ./s21_cat "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test -nb" >> "$B"
cat -nb "$A" > 1 && ./s21_cat -nb "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -nb "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test -bn " >> "$B"
cat -bn "$A" > 1 && ./s21_cat -bn "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_cat -bn "$A"

echo "---------------------------------------------------" >> "$B"

rm 1 2

echo SUCCESS $(grep -c identical "$B")/13
echo check result.txt
make clean
