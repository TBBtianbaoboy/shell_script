#!/bin/sh
#File Name    : a.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-12-01 13:26:30
#Description  : 

#:for debugging and controlling script behavior
set -eu
#:check script but not execute,below is example.
#bash -n main.sh

TYPE=
PICTURE=

checkPicture(){
  PICTURE=$1
  if [ ! -f $PICTURE ];then
    echo "文件不存在"
    return
  fi
}

parseImageType(){
  imageType=${PICTURE##*.}
  if [ $imageType == "png" ];then
    TYPE=png
  elif [ $imageType == "jpg" ];then
    TYPE=JEPG
  else
    echo "未知图片类型"
    return
  fi
}

imageToBase64(){
  IMAGE_BASE64="data:image/$TYPE;base64,$(base64 -w 0 $PICTURE)"
  echo $IMAGE_BASE64
}

main(){
  checkPicture $1
  parseImageType
  imageToBase64
}
main $@
