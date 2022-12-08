#!/bin/bash 

for dir in $(ls $1)

do
        name=$(echo "$dir")
        cp $1/$dir/prac.sh $2/$name.sh

done
