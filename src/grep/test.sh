#!/bin/bash

#no flag
A="file.txt"
B="result.txt"
P="main"

make clean
make debug
rm -rf "$B"

echo "Test no flag" >> "$B"
grep "$P" "$A" "$A" > 1 && ./s21_grep "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -e" >> "$B"
grep -e "$P" "$A" "$A" > 1 && ./s21_grep -e "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -e "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -i" >> "$B"
grep -i "$P" "$A" "$A" > 1 && ./s21_grep -i "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -i "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -v" >> "$B"
grep -v "$P" "$A" "$A" > 1 && ./s21_grep -v "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -v "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -c" >> "$B"
grep -c "$P" "$A" "$A" > 1 && ./s21_grep -c "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -c "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -l" >> "$B"
grep -l "$P" "$A" "$A" > 1 && ./s21_grep -l "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -l "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -n" >> "$B"
grep -n "$P" "$A" "$A" > 1 && ./s21_grep -n "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -n "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -h" >> "$B"
grep -h "$P" "$A" "$A" > 1 && ./s21_grep -h "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -h "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -s" >> "$B"
grep -s "$P" "$A" "$A" > 1 && ./s21_grep -s "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -s "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -f" >> "$B"
grep -f "regex.txt" "$A" "$A" > 1 && ./s21_grep -f "regex.txt" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -f "regex.txt" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -o" >> "$B"
grep -o "$P" "$A" "$A" > 1 && ./s21_grep -o "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -o "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -iv" >> "$B"
grep -iv "$P" "$A" "$A" > 1 && ./s21_grep -iv "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -iv "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -in" >> "$B"
grep -in "$P" "$A" "$A" > 1 && ./s21_grep -in "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -in "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -vs" >> "$B"
grep -vs "$P" "$A" "$A" > 1 && ./s21_grep -vs "$P" "$A" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -vs "$P" "$A" "$A"

echo "---------------------------------------------------" >> "$B"
##multiply files

echo "Test no flag" >> "$B"
grep "$P" "$A" > 1 && ./s21_grep "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -e" >> "$B"
grep -e "$P" "$A" > 1 && ./s21_grep -e "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -e "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -i" >> "$B"
grep -i "$P" "$A" > 1 && ./s21_grep -i "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -i "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -v" >> "$B"
grep -v "$P" "$A" > 1 && ./s21_grep -v "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -v "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -c" >> "$B"
grep -c "$P" "$A" > 1 && ./s21_grep -c "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -c "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -l" >> "$B"
grep -l "$P" "$A" > 1 && ./s21_grep -l "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -l "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -n" >> "$B"
grep -n "$P" "$A" > 1 && ./s21_grep -n "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -n "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -h" >> "$B"
grep -h "$P" "$A" > 1 && ./s21_grep -h "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -h "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -s" >> "$B"
grep -s "$P" "$A" > 1 && ./s21_grep -s "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -s "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -f" >> "$B"
grep -f "regex.txt" "$A" > 1 && ./s21_grep -f "regex.txt" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -f "regex.txt" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -o" >> "$B"
grep -o "$P" "$A" > 1 && ./s21_grep -o "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -o "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -iv" >> "$B"
grep -iv "$P" "$A" > 1 && ./s21_grep -iv "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -iv "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -in" >> "$B"
grep -in "$P" "$A" > 1 && ./s21_grep -in "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -in "$P" "$A"

echo "---------------------------------------------------" >> "$B"

echo "Test flag -vs" >> "$B"
grep -vs "$P" "$A" > 1 && ./s21_grep -vs "$P" "$A" > 2 && diff -s 1 2 >> "$B"
valgrind --tool=memcheck --leak-check=yes ./s21_grep -vs "$P" "$A"

echo "---------------------------------------------------" >> "$B"
rm 1 2

echo SUCCESS $(grep -c identical "$B")/28
echo check result.txt
make clean
