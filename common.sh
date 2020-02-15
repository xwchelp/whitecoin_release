#!/bin/bash

#common.sh
#全局常量

#当前正在运行的whitecoind
readonly  curr_whitecoind="/usr/local/bin/whitecoind"

#远程需要同步的最新whitecoind的git资源
readonly  whitecoind_url="https://github.com/xwchelp/whitecoin_release.git"

#本地whitecoind git资源
readonly  whitecoind_work="${HOME}/whitecoind_sync"

#下载过程中的锁.
readonly  git_clone_lock="${HOME}/.git_clone_lock"

#最新的whitecoind路径
readonly path_whitecoind_last=${whitecoind_work}/whitecoind_last

#最新的checksum记录
readonly whitecoind_last_checksum_text=${whitecoind_work}/whitecoind_last.sha512.sum

#------------------------------------------------------------------------------
function test_output_common()
{
  echo "Start test_output_common ... "
  echo $curr_whitecoind
  echo $whitecoind_url
  echo $whitecoind_work
  echo $git_clone_lock
  echo $whitecoind_last
  echo $whitecoind_last_checksum_text

  echo "End test_output_common !"

}

#test_output_common



#---------------------------------------------------------------------
# usage:
# file_sha512sum filename
# return:
# if filename exist ; then return 0 and echo sha512sum
# if filename doesn't exist;  then return 1 and echo ""

function file_sha512sum()
{
  local filename=$1
  if [ -f $filename ]
  then
    sha512sum $filename | awk '{print $1}'
    return 0
  else
    echo ''
    return 1
  fi
}


#
#--------------------------------------------------
# 计算当前运行的whitecoind的hash
# curr_whitecoind_sum
#
#当前whitecoind路径:  common.sh::curr_whitecoind
# 这里是同时返回 字符串和 命令执行结果的例子
#
function curr_whitecoind_sum()
{
  file_sha512sum $curr_whitecoind
}

#curr_whitecoind_sum


#---------------------------------------
#计算最新的whitecoind的hash
#
function whitecoind_last_sum()
{
   file_sha512sum ${path_whitecoind_last}
}

#echo whitecoind_last_sum begin ...
#whitecoind_last_sum

#---------------------------------------------
#  取最新的whitecoind的hash
#
function get_whitecoind_last_text_sum()
{
  cat ${whitecoind_last_checksum_text} |  awk '{print $1}' | tail -n 1
}

echo get_whitecoind_last_text_sum Begin ....
get_whitecoind_last_text_sum

#----------------------------------
#
