#!/bin/bash

set -eux

echo "Author : giantbranch "
echo
echo "Github : https://github.com/giantbranch/pwn-env-init"
echo

cd ~/
# change sourse to ustc
echo "I suggest you modify the /etc/apt/sources.list file to speed up the download."
echo "Press Enter to continue~"
read -t 5 test
#  sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# change sourse —— deb-src 
 sed -i 's/# deb-src/deb-src/' "/etc/apt/sources.list"
# change pip source
if [ ! -d ~/.pip ]; then
  mkdir ~/.pip
fi
echo -e "[global]\nindex-url = https://pypi.douban.com/simple/\n[install]\ntrusted-host = pypi.douban.com" >  ~/.pip/pip.conf
# support 32 bit
dpkg --add-architecture i386
 apt-get update
#  apt-get -y install lib32z1
 apt-get -y install libc6-i386
# maybe git？
 apt-get -y install git gdb
# install pwntools
 apt-get -y install python3 python3-pip
 pip3 install 'cryptography==38.0.4'
 pip3 install pwntools
# install pwndbg
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
# install peda
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit
# download the libc source to current directory(you can use gdb with this example command: directory ~/glibc-2.24/malloc/)
 apt-get source libc6-dev
# install one_gadget
 apt-get -y install ruby
 gem install one_gadget
# download 
git clone https://github.com/niklasb/libc-database.git ~/libc-database
echo "Do you want to download libc-database now(Y/n)?"
read input
if [[ $input = "n" ]] || [[ $input = "N" ]]; then
	echo "you can cd ~/libc-database and run ./get to download the libc at anytime you want"
else
	cd ~/libc-database && ./get
fi
echo "========================================="
echo "=============Good, Enjoy it.============="
echo "========================================="
