#!/bin/sh
#File Name    : ssi.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-11-06 23:58:58
#Description  : 

#:for debugging and controlling script behavior
set -euo pipefail
#:check script but not execute,below is example.
#bash -n main.sh

ARGS=`getopt -o nvzkb -l net,vim,zsh,kitty,br -- "$@" `
### 作用于参数使用错误时
if [ $? != 0 ];then
  echo "Usage help: ssi -h" >&2;exit 1;
fi
eval set -- "$ARGS"

checkNetworkStatus(){
  STATUS=$(nmcli -t -f STATE general)
  if [[ $STATUS == "connected" ]];then
    echo -n "网络已连接-> "
  else
    echo "网络已断开"
    exit 
  fi 
}

getNetworkInfo(){
  deviceStatus=$(nmcli device status | awk '$3 == "已连接" {print $1,$2,$4}' ORS="💎")
  echo $deviceStatus
  device=$(echo $deviceStatus | awk '{print $1}')
  networkInfo=$(nmcli device show $device | awk '{$1="";print $0}'| awk 'NR==3 || NR==9 || NR==8 {print $0}' ORS="🎊")
  echo $networkInfo

}

aboutIp(){
  checkNetworkStatus
  getNetworkInfo
}

aboutVim(){
  nvim $HOME/.config/nvim/init.vim
}

aboutKitty(){
  nvim $HOME/.config/kitty/kitty.conf
}

aboutBr(){
  nvim $HOME/.config/broot/conf.hjson
}

aboutZsh(){
  nvim $HOME/.zshrc
}

main(){
  while true;do
    case "$1" in 
      -n|--net)
        aboutIp
        exit;;
      -v|--vim)
        aboutVim
        exit;;
      -z|--zsh)
        aboutZsh
        exit;;
      -k|--kitty)
        aboutKitty
        exit;;
      -b|--br)
        aboutBr
        exit;;
      *)
        echo "argus is necessary";exit 1;;
    esac
  done
}
main $@
