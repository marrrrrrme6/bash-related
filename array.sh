#!/bin/bash

for l in `echo {a..z} | tr " " \\\n |shuf -n5` ;do
	array+=($l)
done

echo ${array[@]}
