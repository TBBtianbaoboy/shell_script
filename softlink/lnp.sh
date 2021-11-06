#!/bin/sh
#File Name    : lnp.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-11-05 15:56:55
#Description  : 

#:for debugging and controlling script behavior
set -euo pipefail
#:check script but not execute,below is example.
#bash -n main.sh

getAbslPath(){
  path=`readlink -f $1`
}

createSoftLink(){
  ln -s $path $1
}

main(){
  getAbslPath $1
  createSoftLink $2 

}
main $@
