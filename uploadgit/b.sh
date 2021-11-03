#!/bin/sh
commit_message="lyy"
MAINDIR="$HOME/github/*"
gitall(){
gitDirs=$(readlink -f $MAINDIR | awk '{print $1}')
for dirname in $gitDirs
do
  echo "----------------------------"
  echo "now in: $dirname"
  echo "----------------------------"
  cd $dirname
  git add --all
  git commit -a -m $commit_message 
  git push origin master
done
}
gitall;
