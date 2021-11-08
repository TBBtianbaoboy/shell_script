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

ARGS=`getopt -o nvzkbdwo -l net,vim,zsh,kitty,br,speedtest,release,dns,who,online -- "$@" `
### 作用于参数使用错误时
if [ $? != 0 ];then
  echo "Usage help: ssi -h" >&2;exit 1;
fi
eval set -- "$ARGS"

RED='\033[0;31m' #Red Color 
GREEN='\033[0;32m' #Green Color 
YELLOW='\033[1;33m' #Yellow Color 
NC='\033[0m' # No Color

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

aboutSpeedTest(){
  #wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
  #chmod +x speedtest-cli 
  #sudo mv speedtest-cli ~/bin/speedtestcli
  speedtestcli --share --bytes
}

CommandAbslPath=
# update:this function can be replaced by command
findCommand(){
  IFS=":"
  binArr=($PATH)
  for binDir in ${binArr[@]};do
    if [ ! -d $binDir ];then 
      continue
    fi
    result=$(find $binDir -name $Command)
    if [[ $result != "" ]];then 
      CommandAbslPath=$result
      break
    fi
  done
}

aboutRelease(){
  Command="lsb_release"
  findCommand
  if [[ $CommandAbslPath == "" ]];then
    echo -e "${RED}缺失相应配置，正在加载...${NC}"
    sudo -u root zsh -c 'dnf install -y redhat-lsb-core' >/dev/null
  fi 
  releaseResult=$(lsb_release -a | awk 'NR==1 || NR==3 {print $0}')
  echo $releaseResult
}

aboutDns(){
  nameServer=$(cat /etc/resolv.conf | awk '/^nameserver/ {print $2}')
  echo -e "DNS: ${GREEN}$nameServer"
}

aboutWho(){
  me=$(whoami)
  privilegeMessage=$(sudo -u root zsh -c "cat /etc/sudoers" | awk '/^'$me'/ {print $0}')
  echo -e "Who: ${GREEN}$me${NC}"
  echo -e "Privilege: ${GREEN}$privilegeMessage${NC}"
}

aboutOnline(){
  who
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
      --speedtest)
        aboutSpeedTest
        exit;;
      --release)
        aboutRelease
        exit;;
      -d|--dns)
        aboutDns
        exit;;
      -w|--who)
        aboutWho
        exit;;
      -o|--online)
        aboutOnline
        exit;;
      *)
        aboutIp
        exit;;
    esac
  done
}
main $@
