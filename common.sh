#!/bin/bash

#common.sh
#全局常量

readonly NULL_NO_FILE='NULL_NO_FILE' #返回结果,文件不存在!

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
# if filename doesn't exist;  then return 1 and echo NULL_NO_FILE
# 注释:  校验和返回为'',零长度的字符串,不好做函数参数处理,
#现在返回hash值,如果文件不存在返回 NULL_NO_FILE

function file_sha512sum()
{
  local filename=$1
  if [ -f $filename ]
  then
    sha512sum $filename | awk '{print $1}'
    return 0
  else
    echo $NULL_NO_FILE  #file not exist
    return 1
  fi
}

#test Ok, 2020.2.16

#----------------------------------
# 比较两个校验和是否相等
#
# 1. 两个文件都存在,并且校验和相等,返回为0
# 2. 两个文件都存在,但是校验和不等, 返回 1
# 3. $1, $2都不存在, 返回 2
# 4. 仅仅$1不存在, 返回3
# 5. 仅仅$2不存在, 返回4
#
function compare_sha_sum()
{
  local sha1=$1
  local sha2=$2
  #echo  "sha1=${sha1}, sha2=${sha2}"

  if [ $sha1 = ${NULL_NO_FILE} ]
  then
    if [ $sha2 = ${NULL_NO_FILE} ]
    then
      #echo "2: s1=${sha1}, s2=${sha2}"
      return 2
    else
      #echo "3: s1=${sha1}, s2=${sha2}"
      return 3
    fi
  else
    if [ $sha2 = ${NULL_NO_FILE} ]
    then
      #echo "4: s1=${sha1}, s2=${sha2}"
      return 4
    fi
  fi

  if [ $sha1 = $sha2 ]
  then
       #echo "sha1=sha2"
       return 0
  else
       #echo 'sha1 != sha2'
       return 1
  fi
}

# test ok on 2020.2.16


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
  if [ -f ${whitecoind_last_checksum_text} ]
  then
    cat ${whitecoind_last_checksum_text} |  awk '{print $1}' | tail -n 1
  else
   echo ${NULL_NO_FILE}
  fi
}

echo get_whitecoind_last_text_sum Begin ....
get_whitecoind_last_text_sum

#----------------------------------
# 检查最新whitecoind的hash之否正确
# 1. return 0 = 下载正确,下载文件和文本提供的hash值一致
# 2. return 1 = 下载不成功, 文件计算值和文本提供的值不一致
# 3. return 2 = 两个文件都不存在,
# 4. return 3 = whitecoind_last不存在
# 5. retrun 4 = 记录whitecoind_last hash值的文本文件不存在
#
function check_whitecoind_last_sum()
{
  local sha1=$(whitecoind_last_sum)
  local sha2=$(get_whitecoind_last_text_sum)

  #test only
  #sha1='abc'  #return 1
  #sha1=$NULL_NO_FILE; sha2=$NULL_NO_FILE #return 2
  #sha1=$NULL_NO_FILE  #return 3
  #sha2=$NULL_NO_FILE    #return 4

  compare_sha_sum $sha1 $sha2
}

function test_check_whitecoind_last_sum()
{
  check_whitecoind_last_sum
  echo check_whitecoind_last_sum=$?
}

#test_check_whitecoind_last_sum

# test ok, return [0,1,2,3,4], on 2020.2.16

#----------------------------------
#  判断whitecoind有新版本吗?
#
function check_whitecoind_update()
{
  if check_whitecoind_last_sum
  then
    echo whitecoind  download ok  ...
    sha1=$(curr_whitecoind_sum)
    sha2=$(get_whitecoind_last_text_sum)
    if [[ -n $sha1 && -n $sha2 ]]
    then
      if ! compare_sha_sum $sha1 $sha2
      then
        return 0
      fi
    fi
  else
    echo whitecoind download error ... 
  fi
}

#check_whitecoind_update

#test_compare_sha_sum




###

function ko()
{
  echo hello
  echo enter!
}
