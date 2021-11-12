#!/bin/bash

function title(){
    if [[ $1 = "-T" ]];then
        echo -e "\033[36m$2\033[0m" 
    elif [[ $1 = "-t" ]];then
        echo -e "\033[34m$2\033[0m \033[32m$3\033[0m"
    fi
}

title -T "model title"
title -t "service titile"