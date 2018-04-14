#!/bin/bash

mkdir $1

cd $1

git init

git remote add -t master origin $2

git fetch 


