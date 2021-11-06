#!/bin/sh 
commit_message="'lyy'"
MAINDIR="$HOME/github/*"
gitDirTxt="/tmp/gitdir.txt"
###handle args
ARGS=`getopt -o dtm:,ah -l directory,table,all,help -- "$@" `
### 作用于参数使用错误时
if [ $? != 0 ];then
  echo "Usage help: uplnotgit -h" >&2;exit 1;
fi
eval set -- "$ARGS"

#### shell function demo
checkGitRepoIsChange(){
  if [ -z "$(git status --porcelain)" ];then 
    return 100 
  else 
    return 200 
  fi
}

pushUpdate(){
  checkGitRepoIsChange
  if [ $? == 200 ];then 
    git add --all
    git commit -a -m $commit_message
    git push origin master
  else 
    echo "status:====>nothing to update"
  fi
}

gitall(){
gitDirs=$(readlink -f $MAINDIR | awk '{print $1}')
for dirname in $gitDirs
do
  echo "------------♈--------------"
  echo "now in: $dirname"
  echo "----------------------------"
  cd $dirname
  pushUpdate
done
}

gitdir(){
  echo -n "please input comtent number: "
  read line
  d=$(cat $gitDirTxt | sed -n "${line}p" | awk '{print $2}')
  echo "-------------♈-------------"
  echo "now in: $d"
  echo "----------------------------"
  cd $d
  if [ $d == "$HOME/github/system-config" ];then
    cp $HOME/.config/nvim/init.vim .
    cp $HOME/.zshrc .
    cp $HOME/.config/kitty/kitty.conf .
  fi
  pushUpdate
}

showtable(){
gitDirs=$(readlink -f $MAINDIR | cat -n > $gitDirTxt)
echo "----------------------------"
echo "======directory table======="
echo "----------------------------"
cat $gitDirTxt 
}

showmanual(){
  echo "---------------------------examples----------------------------------------"
  echo "|    1:  uplnotgit -m 'lyy' -d  ||# 自定义commit 指定目录下的所有更新文件 |"
  echo "|    2:  uplnotgit -m 'lyy' -a  ||# 自定义ccommit 所有目录下的所有更新文件|"
  echo "|    3:  uplnotgit -d  ||# 默认commot 指定目录下的所有更新文件            |"
  echo "|    4:  uplnotgit -a  ||# 默认commot 所有目录下的所有更新文件            |"
  echo "|    5:  uplnotgit -t  ||# 查看所有可行目录                               |"
  echo "|    6:  uplnotgit -h  ||# 查看帮助                                       |"
  echo "|--------------------------------------------------------------------------"
}

main(){
while true;do 
  case "$1" in 
    -h|--help) showmanual; exit;;
    -t|--table) showtable;exit;;
    -m)
      substr="-";
      if [[ $2 =~ $substr ]];then
        echo "-m argus is not avaliable"
        exit 1
      fi
      echo "commit message is :'$2'";
      commit_message="'$2'";
      shift 2;;
    -d|--directory) showtable;gitdir;exit;;
    -a|--all) gitall; exit;;
    #args tail,exit
    --)shift;exit ;;
    *)echo "args -a/--all or -d/--directory is necessary";exit 1;;
  esac
done 

}
main $@
