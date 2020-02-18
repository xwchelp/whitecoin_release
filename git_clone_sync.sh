#!/bin/bash
# v0.1
# by john
# date: 2020.2.14

# function:
#1. git clone /git pull whitecoind_release
#2. install whitecoind

. common.sh

# alaway difined in commom.sh:
#readonly  whitecoind_url="https://github.com/xwchelp/whitecoin_release.git"
#readonly  whitecoind_work="${HOME}/whitecoind_sync"
#readonly  git_clone_lock="${HOME}/.git_clone_lock"

#---------------------------------------------------------
#
#check_workdir , if dir exist and ok return ture;
# else dir don't exist or dir error then return false.
function check_workdir()
{
  local result=1
  if   test  -d $whitecoind_work \
         -a  -d ${whitecoind_work}/.git \
    && test  -f ${whitecoind_work}/whitecoind_last.sha512.sum \
         -a  -f ${whitecoind_work}/whitecoind_last
  then
    result=0
  fi

  #  echo "In function check_workdir, result = "$result
  return $result
}


function del_workdir()
{
   if [ -d ${whitecoind_work} ]
   then
     #echo now starting del whitecoind_workdir
     rm -rf ${whitecoind_work}
   fi
}

#echo "test del_workdir ..."
#del_workdir


#-----------------------------------------------------
#
function sync_whitecoind_release()
{
  check_workdir
  local result=$?
   # echo  In sysnc_whitecoind_release, check_workdir = $result
  if [ $result == 0 -a ! -e ${git_clone_lock}  ]  #0=true
  then
    cd $whitecoind_work
    # echo "now begin git pull -----  workdir exist!!"
    git pull
    # if git pull error. then ctrl+c, enter this again, run git pull agagin. good job!
  else
    #echo begin del_workdir ...
    del_workdir

    #echo begin git clone ...
    rm -f ${git_clone_lock}
    touch ${git_clone_lock}
    git clone ${whitecoind_url} ${whitecoind_work}
    rm -f ${git_clone_lock}
  fi
}

function test2_sysnc_whitecoind_release()
{
  #  echo "test2 .... begin start sync_whitecoind_release"
  sync_whitecoind_release
}

#test2_sysnc_whitecoind_release

#----------------------------------------------------
#
function test1_check_workdir()
{
  check_workdir
  result=$?
  echo "check_workdir: "${result}
}

#test1_check_workdir

#----------------------------------------------------
#     本单元主程序
#-------------------------------------------------------
#  repeat_sync_whitecoind
#重复5次,尝试下载和同步github上的whitecoind资源
#返回: 0=同步成功
#      1=同步不成功!
#标准输出,同步过程
#
function repeat_sync_whitecoind()
{
  local sync_ok="Already up-to-date."
  local repeat_times=5


  local int=1
  while (( $int<=$repeat_times ))
  do
    echo "Dwonload try times:  ${int}/${repeat_times}"
    let "int++"

    str_sync=$(sync_whitecoind_release | tail -n 1)
    echo $str_sync
    result="$(echo $str_sync | grep -c "${sync_ok}" )"
    echo "Count include 'Already up-to-date.' number = "$result

    if [ $result == 1 ]
    then
      return 0  #true
    fi
  done

  return 1  # if repeat 5 times then return 1 = false
}

function test_repeat_sync_whitecoind()
{
  echo Start test_repeat_sync_whitecoind
  repeat_sync_whitecoind
  local result=$?
  echo "repeat_sync_whitecoind return = "$result
}

#test_repeat_sync_whitecoind

#apt install -y git zip tmux
