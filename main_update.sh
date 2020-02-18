#!/bin/bash
#----------------------------------------
# 1. download newest whitecoind from github
# 2. check whitecoind integrality
# 3. install newest whitecoind

. common.sh
. git_clone_sync.sh
. check_sha512.sh
. install_whitecoind.sh

#path_curr_whitecoind="/usr/local/bin"
#whitecoind_work="${HOME}/whitecoind_sync"
#whitecoind_last_checksum_text=${whitecoind_work}/whitecoind_last.sha512.sum

#------------------------------------------
# main_update_1
#
# return:
# 0: 有新版本,安装成功
# 1: 没有新版本,无需升级
# 2: 下载文件校验错
# 3: 保留
# 4: 下载文件失败
#
function main_update_1()
{
  # 1. 下载最新的github上的whitecoind资源,
     #git clone /git pull 同步远程资源
  repeat_sync_whitecoind

  if [ $? == 0 ]
  then
    echo "Download OK !"
    echo
    #cd ${whitecoind_work}    #可能也不需要,进入这个程序的时候,就应该保证在这个目录下

    #2. 使用sha512计算,检查下载完整性,并且否有新的版本
    check_whitecoind_update
    local result_check=$?

    case ${result_check}  in
    0)
      echo "0. 有新版本, 开始安装 ..."
      #3. 安装新版本
      do_install_whitecoind
      ;;
    1)
      echo "1. 没有新版本, 无需做任何事情..."
      ;;
    2)
      echo "2. 下载文件校验错误, 请过一段时间再下载 ... "
      ;;
    esac
    return ${result_check}

  else
    echo "Download Whitecoind Error! "
    return 4
  fi

}

# test Ok,  using test_all_main_update_1
#


#--------------------------------------------
#  版本2, 校验错,再下载一次
# git clone, git pull 已经很完善, 为了完美主义,过了过度保险起见,开发这个升级版.
# 返回
# 0: 有新版本,安装Ok
# 1: 没有新版本, 不升级
# 2: 验证错,(已经又下载一次了,还是错, 很有可能是源码错,等开发者修复好再下载)
# 3: 保留
# 4: 网络错, 稍后再下载
#
function main_update_2()
{
  main_update_1
  local result_update_1=$?
  if [ ${result_update_1} == 2  ]     #校验错,再下载一次
  then
    rm -rf  ${whitecoind_work}
    main_update_1
    return $?
  fi
  return ${result_update_1}
}

#test Ok!

