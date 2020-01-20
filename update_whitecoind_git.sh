#file name : update_whitecoind_git.sh
#function : Auto download whitecoind and then replace /usr/local/bin/whitecoind
#version 0.9
#writed by xwc_help
#email: xwc_help@protonmail.com
#date: 2020.1.19

#usage:
# ssh pi@your_raspberry_ip    //default password is "raspberry"
# sudo apt-get install -y zip git tmux
# git clone git@github.com:xwchelp/whitecoin_release.git
# cd whitecoin_release
# ./update_whitecoind_git.sh

path_whitecoind="/usr/local/bin/"

function backup_whitecoind()
{
  cur_path=$(pwd)
  cd ${path_whitecoind}
  sudo rm -f whitecoind.bak.bak
  sudo mv whitecoind.bak whitecoind.bak.bak
  sudo mv whitecoind whitecoind.bak
  cd ${cur_path}
}

function install_whitecoind()
{
  sudo cp ./whitecoind_last ${path_whitecoind}whitecoind
  sudo chown pi:pi ${path_whitecoind}whitecoind
}

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
echo "ls -lh "${path_whitecoind}
ls -lh ${path_whitecoind}

echo
sudo systemctl status whitecoin
echo  "Done All!"




