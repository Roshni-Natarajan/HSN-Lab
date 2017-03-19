#!/bin/bash

echo "Delay">Delay_2
for f in $@
do
  tail -n +15 "$f" > "$f-processed.txt"

while read line
do
str=$line
done < "$f-processed.txt"
count=0
j=0

for (( i = 0; i < ${#str}; ++i));
do

if [ "${str:$i:1}" == "/" ]
then

count=$((count+1))
if [ $count == 4 ]
then

k=$((i+1))
while [ "${str:$k:1}" != "/" ]
do y[$k]=${str:$k:1};
k=$((k+1));
done
var=$(echo ${y[@]} | tr -d ' ')
echo $var>> Delay_2
fi
fi
done

done
