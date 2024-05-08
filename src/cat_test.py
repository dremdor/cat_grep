import os
import subprocess
from filecmp import cmp
from itertools import combinations

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

your_cat = "./cat/s21_cat"
original_cat = "cat"
test_files_dir = "tests/"
remove_files = "rm -rf *.txt s21_cat"
compile_gcc = "make"
test_files = [f"TEST-FILE_{str(i).zfill(3)}" for i in range(1, 6)]

short_flags = ['e', 's', 'b', 'n', 'v', 't']

#subprocess.run(compile_gcc, shell=True)

for file in [os.path.join(test_files_dir, tf) for tf in test_files]:
    file = file + ".txt"
    if not os.path.exists(file):
        print(f"File {file} does not exist!")
        exit(1)

flag_combinations = []
for r in range(1, len(short_flags) + 1):
    for combination in combinations(short_flags, r):
        flag_combinations.append(list(combination))

for test_file in test_files:
    test_file_path = os.path.join(test_files_dir, test_file) + ".txt"

    for flag_combination in flag_combinations:
        for cat_cmd, output_file in [(your_cat, "your_output.txt"), (original_cat, "original_output.txt")]:
            flags = " ".join(f"-{flag}" for flag in flag_combination) if isinstance(flag_combination, list) else f"--{flag_combination}"
            cmd = f"{cat_cmd} {flags} {test_file_path} > {output_file}"
            subprocess.run(cmd, shell=True)

        if cmp("your_output.txt", "original_output.txt"):
            print(bcolors.OKGREEN + f"TEST PASSED: {test_file} with flag combination {flags}" + bcolors.ENDC)
        else:
            print(bcolors.WARNING + f"CMD: {cmd}\t" + bcolors.FAIL + f"TEST FAILED: {test_file} with flag combination {flags}" + bcolors.ENDC)
            #exit(1)
            
#subprocess.run(remove_files, shell=True)