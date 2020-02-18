#!/bin/bash

#common.sh
#全局常量

#readonly
  NULL_NO_FILE='NULL_NO_FILE' #返回结果,文件不存在!

# 当前运行的whitecoind 路径
  path_curr_whitecoind="/usr/local/bin"
  path_whitecoind=${path_curr_whitecoind}

#当前正在运行的whitecoind
#readonly
  curr_whitecoind=${path_curr_whitecoind}/whitecoind

#远程需要同步的最新whitecoind的git资源
#readonly
  whitecoind_url="https://github.com/xwchelp/whitecoin_release.git"

#本地whitecoind git资源
#readonly
  whitecoind_work="${HOME}/whitecoind_sync"

#下载过程中的锁.
#readonly
  git_clone_lock="${HOME}/.git_clone_lock"

#最新的whitecoind路径
#readonly
  path_whitecoind_last=${whitecoind_work}/whitecoind_last

#最新的checksum记录
#readonly
  whitecoind_last_checksum_text=${whitecoind_work}/whitecoind_last.sha512.sum

#------------------------------------------------------------------------------
function test_output_common()
{
  echo "Start test_output_common ... "
  echo "当前运行的whitecoind所在目录: "$path_curr_whitecoind
  echo "当前运行的whitecoind所在目录: "$path_whitecoind
  echo "当前运行的whitecoind全路径: "$curr_whitecoind

  echo "whitecoind github 资源URL: "$whitecoind_url
  echo "whitecoind资源的同步目录 : "$whitecoind_work
  echo "下载锁文件: "$git_clone_lock
  echo "最新的 whitecoind_last文件全路径: "$path_whitecoind_last
  echo "whitecoind_last sha512sum校验和文件全路径: "$whitecoind_last_checksum_text

  echo "End test_output_common !"

}

#test_output_common


