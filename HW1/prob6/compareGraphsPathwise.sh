#!/bin/bash
FILE="./compareGraphsPathwise"
if [[ ! -f $FILE ]];then
    g++ -o compareGraphsPathwise -Wall compareGraphsPathwise.cpp
fi
./compareGraphsPathwise $1 $2