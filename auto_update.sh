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

readonly workdir="${HOME}/.tmp_john_update"
function makeworkdir()
{
  local work_dir=$1
  mkdir -p $work_dir 
  #> /dev/null 2>&1
}

readonly url_whitecoind_last_sum='https://raw.githubusercontent.com/xwchelp/whitecoin_release/master/whitecoind_last.sha512.sum'
function get_whitecoind_last_sum()
{
  local cur_dir=$(pwd)
  makeworkdir $workdir
  cd $workdir
  echo $(wget --no-check-certificate  -o whitecoind_last.sha512.sum url_whitecoind_last_sum > /dev/null 2>&1 )
  echo $(cat whitecoind_last.sha512.sum | awk '{print $1}' | tail -n 1)
  cd $cur_dir
  return 0
}

function file_sha512sum()
{
  local  filename=$1
  sha512sum $filename | awk '{print $1}'
  return 0
}

function curr_whitecoind_sum()
{
  local curr_filename="/usr/local/bin/whitecoind"
  if [ -f $curr_filename ]
  then
    echo $(file_sha512sum $curr_filename | tail -n 1)
    return 0
  else
    echo ''
    return 1
  fi
}





#sudo apt install -y zip git tmux

function test_sha512sum()
{
  curr_file='/usr/local/bin/whitecoind'
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

last_sum=$(get_whitecoind_last_sum)
echo last_sum


#makeworkdir $workdir

#echo "make dir = "$workdir
#mkdir -p ${workdir}
#mkdir -p tmp

#sudo apt install -y zip git tmux
