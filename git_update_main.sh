#!/bin/bash
#----------------------------------------
# 1. download newest whitecoind from github
# 2. check whitecoind integrality
# 3. install newest whitecoind

. common.sh
. git_sync_whitecoind.sh
#. update_whitecoind_git.sh

#------------------------------------------
#
#1. 下载最新的github上的whitecoind资源
repeat_sync_whitecoind     //git clone /git pull 同步远程资源

#2. 检查下载完整性,并且否有新的版本
if check_whitecoind_update
then
  #3. 安装新版本
  update_whitecoind_git.sh
fi

