#!/bin/bash

for f in $@
do
  tail -n +1  "$f" | awk '{ if ($1 == 64) print $5"="$7}'  > "$f-read.txt"
done    

