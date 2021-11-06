#!/bin/sh
#File Name    : aimu.sh
#Author       : aico
#Mail         : 22376Command60Command4@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 202Command-CommandCommand-05 20:Command2:53
#Description  : 

#:for debugging and controlling script behavior
set -exu 
#:check script but not execute,below is example.
#bash -n main.sh
HOME=/home/aico
ZSHRC=$HOME/.zshrc

RED='\033[0;31m' #Red Color 
GREEN='\033[0;32m' #Green Color 
YELLOW='\033[1;33m' #Yellow Color 
NC='\033[0m' # No Color

# trap '' INT
# trap '' QUIT
# trap '' ABRT
CommandAbslPath=
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

installCommand(){
  dnf install -y $1
}

isInstalled(){
  findCommand
  if [[ $CommandAbslPath != "" ]];then
    echo -e "${YELLOW}$Command Has Installed!${NC}-->$CommandAbslPath"
  else 
    installCommand $Command
    if [ $? == 0 ];then
      echo -e "${GREEN}Install $Command Successful${NC}"
    else 
      echo -e "${RED}Install $Command Failed${NC}"
      exit
    fi
  fi
}

isConfiged(){
  if [[ `cat $ZSHRC | awk '/^alias '$zshprefix'/'` == $zshCommand ]];then
    echo -e "${YELLOW}$Command Has Configed ${NC}-->$ZSHRC"
  else 
    echo -e "#$Command\n$zshCommand" >> $ZSHRC
    if [ $? == 0 ];then
      echo -e "${GREEN}Config $Command Successful${NC}"
    else 
      echo -e "${RED}Config $Command Failed${NC}"
    fi
  fi
}

printComma(){
  echo "-----------------------------"
}

#:install bat //replace cat
bat(){
  Command="bat"
  isInstalled
  zshCommand="alias cat='bat'"
  zshprefix="cat="
  isConfiged
  printComma
}

#:install dust //repalce du 
dust(){
  Command="dust"
  cd /tmp 
  wget https://github.com/bootandy/dust/releases/download/v0.7.5/dust-v0.7.5-x86_64-unknown-linux-gnu.tar.gz
  tar xzvf dust-v0.7.5-x86_64-unknown-linux-gnu.tar.gz
  mv dust-v0.7.5-x86_64-unknown-linux-gnu/dust /usr/bin/dust 
  rm -fr dust-v0.7.5-x86_64-unknown-linux-gnu*
  zshCommand="alias du='dust'"
  zshprefix="du="
  isConfiged
  printComma
}

#: install df //replace df 
duf(){
  Command="duf"
  cd /tmp 
  git clone https://github.com/muesli/duf.git
  cd duf
  go build
  mv duf /usr/bin/duf
  cd .. && rm -fr duf
  zshCommand="alias df='duf'"
  zshprefix="df="
  isConfiged
  printComma
}

#: install broot //replace tree 
broot(){
  rm -f broot
  wget https://dystroy.org/broot/download/x86_64-linux/broot
  chmod +x broot 
  mv broot /usr/bin 
  #use way 
  # first broot 
  # future br
}

#: install gping //graical ping 
gping(){
   dnf copr enable atim/gping -y && dnf install -y gping
}

main(){
  # bat
  # dust
  # duf
  # broot
  # gping
  # sudo -u aico zsh -c 'source '$ZSHRC''
}
main

