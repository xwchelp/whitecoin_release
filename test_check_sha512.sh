#!/bin/bash
# This script only for GUI php call. not for man.
#
#1. download this shell script
#2. run this Shell script
#3. create tmp work dir
#4. download whitecoid_last.sha512.sum => last_sum
#5. Workout /usr/local/bin/whitecoind sha512.sum => cur_sum
#6. if last_sum=cur_sum then exit
#7.
#8. down_sum=0
#9. if existed(~/whitecoin_release/whitecoind_last ) then
#   sha512sum(~/whitecoin_release/whitecoind_last) => down_sum
#10. if down_sum=last_sum then goto install_whitecoind
#11.  rm -rf ~/whitecoin_release
#12  download ~/whitecoin_release/whitecoind_last
#13.  goto 10
#14. install:
#15. update_whitecoind_git.sh

#--------------------------------------------
# 模块功能: 计算文件的sha512sum
# 1. 计算当前运行的whitecoind的hash: curr_whitecoind_sum
# 2. 计算下载下来的最新文件的hash:
# 3. 比较下载的文件hash和 文本记录的hash,验证下载是否正确
# 4. 最新下载的文件hash同运行的文件的hash是否一样,确认版本是否一致
#

#echo $SHLVL

#readonly workdir="${HOME}/.tmp_john_update"  # "~" not used, must use ${HOME}

. common.sh
. check_sha512.sh


function makeworkdir()
{
  local work_dir=$1
  mkdir -p $work_dir > /dev/null 2>&1
}

# This ways baned by GFW!!!  GIVE UP!
readonly url_whitecoind_last_sum='https://raw.githubusercontent.com/xwchelp/whitecoin_release/master/whitecoind_last.sha512.sum'
function get_whitecoind_last_sum()
{
  local cur_dir=$(pwd)
  makeworkdir $workdir
  cd $workdir

  echo "Shell level = "$SHLVL
  echo "pwd = "$(pwd)
  echo "\$workdir = "$workdir

  rm -f "${workdir}/whitecoind_last.sha512.sum"
  `wget --no-check-certificate  -o whitecoind_last.sha512.sum ${url_whitecoind_last_sum} > /dev/null 2>&1 `
  echo $(cat whitecoind_last.sha512.sum | awk '{print $1}' | tail -n 1)
  #cd $cur_dir
  return 0
}


#---------------------------------------------------------------------
# usage:
# file_sha512sum filename
# return:
# if filename exist ; then return 0 and echo sha512sum
# if filename doesn't exist;  then return 1 and echo ""

function test1_file_sha512sum()
{
  echo "begin test1_file_sha512sum"
  local file="/usr/local/bin/whitecoind"
  echo $(file_sha512sum $file)
}

#test1_file_sha512sum

function test2_file_sha512sum()
{
  echo "Begin test2_file_sha512sum"
  echo "This example, The Next line is "$NULL_NO_FILE
  local file="/usr/local/bin/erro_nonfile"
  echo $(file_sha512sum $file)
}

#test2_file_sha512sum

function test3_file_sha512sum()
{
  echo "begin test3_file_sha512sum"
  echo "This example must show RIGHT sha512hash, and return 0"
  local file="/usr/local/bin/whitecoind"
  local sum=$(file_sha512sum $file)
  echo "return ="$?
  echo $sum
}

#test3_file_sha512sum

function test4_file_sha512sum()
{
# 经过测试, 函数的两种返回方式,不能同时引用
  echo test4_file_sha512sum
  echo "this example must return 1,(ERROR!) and show ${NULL_NO_FILE}"
  echo " 经过测试, 函数的两种返回方式,不能同时引用, 所以返回结果1,丢失.最终返回0 !!!!"
  local file="/usr/nothis_file_erro"
  local sum=$(file_sha512sum $file)
  echo "return="$?  #not get right return value of file_sha512sum
  echo $sum
}

#test4_file_sha512sum

function test5_file_sha512sum()
{
  echo test5_file_sha512sum
  local file="/usr/nothis_file_erro"
  local sum=$(file_sha512sum $file)
  echo $sum
  file_sha512sum $file > /dev/null 2>&1
  echo "return="$?

}

#test5_file_sha512sum


function test_all_file_sha512sum()
{
  echo 1:
  test1_file_sha512sum
  echo 2:
  test2_file_sha512sum
  echo 3:
  test3_file_sha512sum
  echo 4:
  test4_file_sha512sum
  echo 5:
  test5_file_sha512sum
}

#test_all_file_sha512sum



#--------------------------------------------------
# 计算当前运行的whitecoind的hash
# curr_whitecoind_sum
#
#当前whitecoind路径:  common.sh::curr_whitecoind
# 这里是同时返回 字符串和 命令执行结果的例子
#

#curr_whitecoind_sum


function test_curr_whitecoind_sum()
{
  local sum=$(curr_whitecoind_sum)
  echo $sum
  return 0
}

#test_curr_whitecoind_sum


#----------------------------------------------------------------

#sudo apt install -y zip git tmux

function test_sha512sum()
{
  local curr_file='/usr/local/bin/whitecoind'
  echo $(file_sha512sum $curr_file | tail -n 1)

  echo test0
  echo $filename

  echo "a="${a} 
  b=88
  return 0
}


function test2()
{

  echo test1
  echo $filename
  test_sha512sum

  echo test2
  echo $filename

  echo $a
  echo "b="${b}

}

#test2

#curr_whitecoind_sum

#get_whitecoind_last_sum
#last_sum=$(get_whitecoind_last_sum)
#echo last_sum


#makeworkdir $workdir

#echo "make dir = "$workdir
#mkdir -p ${workdir}
#mkdir -p tmp

function test_compare_sha_sum()
{
  echo
  echo  ---------------------------------
  echo Test compare_sha_sum ...
  echo output must 0,1,2,3,4


  local s1="abc"
  local s2="abc"
  compare_sha_sum $s1 $s2
  echo $?

  local s1="abc"
  local s2="abcd"
  compare_sha_sum $s1 $s2
  echo $?

  local s1=${NULL_NO_FILE}
  local s2=${NULL_NO_FILE}
  compare_sha_sum $s1 $s2
  echo $?

  local s1=${NULL_NO_FILE}
  local s2="a"
  compare_sha_sum $s1 $s2
  echo $?

  local s1="a"
  local s2=${NULL_NO_FILE}
  compare_sha_sum $s1 $s2
  echo $?

  return 0

}

#test_compare_sha_sum
#echo test_compare_sha_sum=$?

#调用函数必须马上使用 $? 才行,否则就可能丢失
#哪怕后面没有要执行的语句也可能会丢失,经测试
#1,空行不影响结果
#2,注释行不影响结果
#3,函数,哪怕不调用,也会影响结果## 这个就要超级注意!!
#4,语句,肯定影响结果



