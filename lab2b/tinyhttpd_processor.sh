#!/bin/bash

for f in $@
do
  tail -n +17 "$f" | awk '{ if ($2 != 1 && $2 != 3) print}'  > "$f-processed.txt"
done
