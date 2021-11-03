#!/bin/sh 
commit_message="lyy"
MAINDIR="$HOME/github/*"
###handle args
ARGS=`getopt -o d:m:,aht -l directory:,all,help,table -- "$@" `
# ## 作用于参数使用错误时
if [ $? != 0 ];then
  echo "Usage help: uplnotgit -h" >&2;exit 1;
fi
eval set -- "$ARGS"
#### shell function demo
gitall(){
gitDirs=$(readlink -f $MAINDIR | awk '{print $1}')
for dirname in $gitDirs
do
  echo "----------------------------"
  echo "now in: $dirname"
  echo "----------------------------"
  cd $dirname
  git add --all
  git commit -a -m '$commit_message'
  git push origin master
done
}

main(){
while true;do 
  case "$1" in 
    -h|--help) echo "show help manual"; exit;;
    -t|--table) echo "show directory table ";exit;;
    -m) echo "commit message is :'$2'";
      commit_message="'$2'";
      shift 2;;
    -d|--directory) echo "handle directory:$2";exit;;
    -a|--all) gitall; exit;;
    #args tail,exit
    --)shift;exit ;;
    *)echo "args -a/--all or -d/--directory is necessary";exit 1;;
  esac
done 

}
main $@
