#!/bin/bash

#file name : update_whitecoind_git.sh
#function : Auto download whitecoind and then replace /usr/local/bin/whitecoind
#version 0.10
#writed by xwc_help
#email: xwc_help@protonmail.com
#date: 2020.1.19
#date-last: 2020.2.12

#usage:
# ssh pi@your_raspberry_ip    //default password is "raspberry"
# sudo apt install -y zip git tmux
# git clone git@github.com:xwchelp/whitecoin_release.git
# cd whitecoin_release
# ./update_whitecoind_git.sh

. common.sh

# dinfined in common.sh:
#path_curr_whitecoind="/usr/local/bin"
#curr_whitecoind=${path_curr_whitecoind}/whitecoind

function backup_whitecoind()
{

  if [ -d ${path_curr_whitecoind} ]
  then
    cur_path=$(pwd)

    cd ${path_curr_whitecoind}
    sudo rm -f whitecoind.bak.bak
    if [ -f whitecoind.bak ]
    then
      sudo mv whitecoind.bak whitecoind.bak.bak
    fi

    if [ -f whitecoind ]
    then
      sudo mv whitecoind whitecoind.bak
    fi

    cd ${cur_path}
  fi

}

function install_whitecoind()
{
  if [ ! -e ${path_curr_whitecoind} ]
  then
    sudo mkdir -p ${path_curr_whitecoind}
  fi

  sudo cp ${whitecoind_work}/whitecoind_last ${curr_whitecoind}
  sudo chown pi:pi ${curr_whitecoind}
}

function do_install_whitecoind()
{

  echo "Stop whitecoin service"
  sudo systemctl stop whitecoin

  echo "Backup Whitecoind file"
  backup_whitecoind

  echo "Install whitecoind"
  install_whitecoind

  echo "Restart whitecoind"
  sudo systemctl start whitecoin
  sudo systemctl enable whitecoin

  echo
  echo "ls -lh "${path_curr_whitecoind}
  ls -lh ${path_curr_whitecoind}

  echo
  sudo systemctl status whitecoin
  echo  "Done All!"

}

#do_install_whitecoind



