#!/bin/bash

fileA=$(echo "$2.asm")
fileO=$(echo "$2.o")
fileB=$(echo "$2")

run() {
	./$fileB
	stat=$(echo $?)
	if [[ $stat == 0 ]]; then
		echo "[  OK  ] Run Binary : Exit Status = $stat"
       	else
		echo "[  ERR ] Run Binary : Exit Status = $stat"
	fi
}

helpE() {
	printf "This is a simple script created to compile x86 32bit nasm assembly code:\n\n-h : to see this menu.\n-l 'file_name_no_extension' : uses the ld command to create binary.\n-g 'file_name_no_extension' : uses the gcc command to create binary,\nthis should be used when C methods have been added into Assembly program for example 'printf'.\n\nCreated by C Human - 2019\n"
}

if [[ $# == 2 ]]; then
	if nasm -f elf32 $fileA -o $fileO; then
		echo '[  OK  ] NASM Compile'
		if [[ $1 == "-l" ]]; then
			if ld -m elf_i386 $fileO -o $fileB; then
				echo '[  OK  ] LD Binary Creation'
				run
			else
				echo '[  ERR ] LD Binary Creation'
			fi
		elif [[ $1 == "-g" ]]; then
			if gcc -m32 $fileO -o $fileB; then
				echo '[  OK  ] GCC Binary Creation'
				run
			else
				echo '[  ERR ] GCC Binary Creation'
			fi
		else
			helpE
		fi
	else
		echo '[  ERR ] NASM Compile, Execution Stopped'
	fi
else 
	helpE
fi
