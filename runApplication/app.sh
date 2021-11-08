#!/bin/sh
#File Name    : app.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-11-07 20:18:40
#Description  : 

#:for debugging and controlling script behavior
set -euo pipefail
#:check script but not execute,below is example.
#bash -n main.sh

runMusic(){
  music
}

main(){
  case $1 in 
    music)
      runMusic
      exit;;
  esac 
}
main $@
