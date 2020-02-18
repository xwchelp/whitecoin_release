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
    result_check=$?

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

#测试1:
readonly return_info="[0=有新版本,升级OK,  1=无新版本, 2=下载文件校验错误, 3=保留, 4=网络错误,无法下载 ]"
function test1_main_update()
{
  main_update_1
  echo "return="$?
  echo "正常测试,${return_info}"
}

#test1_main_update

function test3_main_update()
{
  rm -rf  ${whitecoind_work}
  main_update_1
  echo "return="$?
  echo "正常测试,${return_info}"
}

#test3_main_update



#测试案例1:
# return=1, 版本一样, 无需更新
# 结论: test Ok!

#测试案例2:
#拔掉网线,return=4,网络错误,可以看到内部命令的提示,5次都有发生错误.
#结论: test ok!

#测试案例3:
# run: test3_main_update
# 删除 ${whitecoind_work}, 再运行同步升级
# 可以看到 会git clone 下载文件
#最后返回 1, 版本一样,无需更新
#结论: tesk Ok!

function test4_main_update()
{
  echo
  echo test4_main_update
  echo "删除了当前正在运行的whitecoind,应该升级,自动安装"
  sudo rm -rf  ${path_curr_whitecoind}
  main_update_1
  echo "return="$?
  echo "应该升级,自动安装,返回0,${return_info}"
}

#test4_main_update

#测试案例4:
# run : test4_main_update
# 删除了当前正在运行的whitecoind,应该升级,自动安装
# 可以看到程序运行过程如预期的一样
# 最后返回 0, 安装新版本
# 结论: test ok!


function test5_main_update()
{
  echo
  echo test5_main_update
  echo "删除了当前正在运行的whitecoind, 以及${whitecoind_work},应该下载并升级,自动安装"
  sudo rm -rf  ${path_curr_whitecoind}
  rm -rf  ${whitecoind_work}

  main_update_1
  echo "return="$?
  echo "应该下载升级,自动安装,返回0,${return_info}"
}

#test5_main_update

#测试案例5:
# run test5_main_update
# 删除 ${path_curr_whitecoind} 和${whitecoind_work}连个目录
# 应该 先下载,在安装
# 最后返回0,安装新版本
# 实际与预计的一样
# 结论: tesk ok!

function test6_main_update()
{
  echo test6_main_update
  echo "删除校验hash文本文件,自动修正这个错误,重新git clone,,return=1"
  echo "删除 ${whitecoind_last_checksum_text}"
  rm -f ${whitecoind_last_checksum_text}

  main_update_1
  echo "return="$?
  echo "返回应该为1,${return_info}"

}

#test6_main_update

#测试6_1:
#发现,网络不好,git clone会进行两次,第三次用git pull确认.好现象,程序按照预期运作!

#测试6_2:
#run test6_main_update
#删除 ${whitecoind_last_checksum_text}, 之后运行 main_update_1,
#发现 程序自动 删除破坏的,工作目录全部文件,再进行git clone
#这是原先设计的行为, 测试用例设计错误
#应该返回 1, 没有升级.修改测试用例
# 结论: test ok

function test7_main_update()
{
  echo test7_main_update
  echo "加点东西到hash文本文,校验应该不能通过,return=2"
  echo "Error_add_some_to_sha512file_for_test" >>  ${whitecoind_last_checksum_text}

  main_update_1
  echo "return="$?
  echo "返回应该为2,${return_info}"

}

#test7_main_update

function test_all_main_update_1()
{
  test1_main_update
  test3_main_update
  test4_main_update
  test5_main_update
  test6_main_update
  test7_main_update

  #删除目标文件夹,删除工作文件夹,完全重新安装.
  #恢复运行环境
  test5_main_update
}

test_all_main_update_1
