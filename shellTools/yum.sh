#!/bin/bash

function yumLocalInstall(){
    SOFT_NAME=$1
    RPM_DIR=$2
    [[ ! -d ${RPM_DIR} ]] &&  log -e "未找到安装 ${SOFT_NAME} 相关的RPM包"
    cd ${RPM_DIR} 
    log "yum安装 ${RPM_DIR}"
    yum -y localinstall *
    systemctl enable ${SOFT_NAME}
    cd -
}