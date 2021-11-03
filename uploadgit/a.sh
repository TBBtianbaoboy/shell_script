#!/bin/sh
a(){
gitDirs=$(readlink -f ~/github/* | awk '{print $1}')
for dirname in $gitDirs
do
  echo "----------------------------"
  echo "now in: $dirname"
  echo "----------------------------"
done
}
a;
