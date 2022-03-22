#!/bin/sh 
Strs="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz;.,"
length=$1
if [ "$length" = "" ];then
  length="10"
fi

while [ "${n:=1}" -le "$length" ]
do
  ranstr="${ranstr}${Strs:$(($RANDOM%${#Strs})):1}"
  let n+=1
done 
echo "$ranstr"
exit 0;
