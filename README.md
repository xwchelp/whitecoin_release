# whitecoin_release

[Click this for download whitecoind_2.5.4](https://github.com/xwchelp/whitecoin_release/raw/master/whitecoind_2.5.4)

Please update to Whitecoin 2.5.4 for your Whitenode(raspbarry pi 3B)

### Onekey update way:  
1. $ ssh pi@your_raspberry_pi    
2. $ wget https://github.com/xwchelp/whitecoin_release/raw/master/update_whitecoind.sh && chmod +x update_whitecoind.sh && ./update_whitecoind.sh   

### Use git update way:
1. $ ssh pi@your_raspberry_ip    //default password is "raspberry"
2. $ sudo apt-get install -y zip git tmux
3. $ git clone git@github.com:xwchelp/whitecoin_release.git
4. $ cd whitecoin_release
5. $ ./update_whitecoind_git.sh


# 简体中文
### 使用gitclone下载安装:
1. $ ssh pi@your_raspberry_ip    //树梅派矿机缺省密码 "raspberry"
2. $ sudo apt-get install -y zip git tmux
3. $ git clone git@github.com:xwchelp/whitecoin_release.git
4. $ cd whitecoin_release
5. $ ./update_whitecoind_git.sh
6  安装完成,可以在 浏览器查看你的矿机,地址栏输入:  https://your_raspberry_ip

7. 注意1: $是树梅派给的提示信息,不用输入, 第一行 //之后是注释,不用输入
        用拷贝粘贴的方法,避免输入错误.
8. 注意2: 本方法建议有一定的电脑知识的朋友使用,或者看更详细的教程


