#!/bin/bash
FILE="./compareGraphsPathwise"
if [[ ! -f $FILE ]];then
    g++ -o compareGraphsPathwise -I../ -Wall compareGraphsPathwise.cpp
fi
./compareGraphsPathwise $1 $2