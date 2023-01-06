#!/bin/bash
# First and only argument should be a file with the .asm extension
file=$1
file_no_extension=${file%.*}
file_exe_extension="${file_no_extension}.exe"
file_object_extension="${file_no_extension}.o"
nasm -f elf64 $file
ld $file_object_extension -o $file_exe_extension
