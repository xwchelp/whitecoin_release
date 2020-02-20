#!/bin/bash
# This script install some scripts for updating whitecoind to whitenode image file at building whitenode image
# Building server must be in out of GFW, Or don't download github files

sudo apt -y git zip
if [ -d ~/whitecoind_sync ]
then
   cd ~/whitecoind_sync
   git pull
else
   cd ~
   git clone https://github.com/xwchelp/whitecoin_release.git ~/whitecoind_sync
fi

if [ -d ~/script_whitecoind ]
then
  rm -rf ~/script_whitecoind
else
  cp -rf ~/whitecoind_sync/script ~/script_whitecoind
fi

# The end !

# Now, php GUI can call this script for update whitecoind:
# 1. cd ~/script_whitecoind
# 2. start_update.sh

#
#start_update.sh 返回值:
#0=有新版本,更新成功! (本地文件可以没有,没关系)
#1=版本一样, 无需更新
#2=下载校验和错误, 很有可能是源码错误,等待开发者更新
#3=内部错误,保留
#4=下载错误,网络错误,等一段时间再来尝试
#注释: 返回值 shell中使用$?获取,必须马上获取.
#
