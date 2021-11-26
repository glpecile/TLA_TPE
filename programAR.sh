#!/bin/bash
./programAR.out < $1 > programAR.code.c
gcc -w programAR.code.c -o $2
rm programAR.code.c