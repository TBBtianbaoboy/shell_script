#!/bin/bash

function log(){
    if [[ $1 = "-w" ]];then
        echo -e "\033[33m[WARNING]\033[0m" $2
    elif [[ $1 = "-e" ]] ;then
        echo -e "\033[31m[ERROR]\033[0m" $2
        exit 127
    else 
        echo -e "\033[32m[INFO]\033[0m" $1
    fi
}

log "this is info" 
log -w "this is warning"
log -e "this is error"