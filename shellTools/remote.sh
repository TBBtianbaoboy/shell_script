#!/bin/bash
function RhostSet(){	#初始化远程连接
    HOSTNAME=$1
    HOSTIP=$2
    USERNAME=$3
    PASSWORD=$4
    [[ -n $5  ]] && PORT=$5 || PORT=22
}

function RexecCommand(){    #远程执行命令
    command=$1
    sshpass -p ${PASSWORD} ssh -o "StrictHostKeyChecking no" ${USERNAME}@${HOSTIP} ${command}
}

function RexecScript(){     #远程脚本执行
    script=$1
    sshpass -p ${PASSWORD} ssh -o "StrictHostKeyChecking no" ${USERNAME}@${HOSTIP} "bash -s" < ${script}
    code=$?
    [[ ${code} != 0 ]] && info "在主机${HOSTIP}执行脚本${script},返回码为${code}" 
}

function RcopyFile(){       #远程文件拷贝
    src=$1
    dst=$2
    sshpass -p ${PASSWORD} scp -r -o "StrictHostKeyChecking no" ${src}  ${USERNAME}@${HOSTIP}:${dst}
    [[ $? != 0 ]] && warnning "将本地文件${src}拷贝到主机${HOSTIP}的${dst}失败"
}