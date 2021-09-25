#!/bin/bash
FILE="./compareGraphsPathwise.o"
if [[ ! -f $FILE ]];then
    g++ -o compareGraphsPathwise.o -Wall compareGraphsPathwise.cpp
fi
./compareGraphsPathwise.o $1 $2