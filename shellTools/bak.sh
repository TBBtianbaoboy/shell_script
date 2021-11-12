#/bin/bash

function bak () {
    if [[ -f $1 ]];then
        cp $1 $1_moresec_bak
    fi
}

bak ./hello