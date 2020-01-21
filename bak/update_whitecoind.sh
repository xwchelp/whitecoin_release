#file name : update_whitecoind.sh
#function : Auto download whitecoind and then replace /usr/local/bin/whitecoind
#version 0.9
#writed by xwc_help
#email: xwc_help@protonmail.com
#date: 2020.1.19

#usage:
#wget https://github.com/xwchelp/whitecoin_release/raw/master/update_whitecoind.sh && chmod +x update_whitecoind.sh && ./update_whitecoind.sh

path_whitecoind="/usr/local/bin"

function backup_whitecoind()
{
  cd ${path_whitecoind}
  sudo rm -f whitecoind.bak.bak
  sudo mv whitecoind.bak whitecoind.bak.bak
  sudo mv whitecoind whitecoind.bak
}

echo install zip tools package
sudo apt-get install -y zip


#cur_path=$(pwd) && echo $cur_path #test ok!
cur_path=$(pwd)  #current path

cd ~
mkdir .xwc_help
cd .xwc_help

echo Download whitecoind_lastest
#wget https://github.com/xwchelp/whitecoin_release/raw/master/whitecoind_2.5.4
wget  https://github.com/xwchelp/whitecoin_release/raw/master/whitecoind_last

echo "Stop whitecoin service"
sudo systemctl stop whitecoin

cd ${path_whitecoind}

echo "Backup Whitecoind file"
backup_whitecoind

echo "Install whitecoind"
sudo cp ~/.xwc_help/whitecoind_lastest whitecoind
sudo chown pi:pi whitecoind

echo "Restart whitecoind"
sudo systemctl start whitecoin
sudo systemctl enable whitecoin

echo "Clear tmp dir"
cd ~
rm -rf ~/.xwc_help

cd ${cur_path}

echo  "Done All!"




