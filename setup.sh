#!/usr/bin/env -S bash
#リポジトリのアップデート
apt update -y
apt upgrade -y

#gcc関係
apt install gcc-i686-linux-gnu -y
apt install gcc-x86-64-linux-gnu -y
apt install gcc-arm-linux-gnueabi -y
apt install gcc-aarch64-linux-gnu -y

#python関係
apt install python3 -y
apt install python3-full -y
apt install python3-pip -y
apt install python3-sphinx -y

#gui関係
apt install openbox -y
apt install tightvncserver -y

#Java関係
apt install openjdk-8-jre -y
apt install openjdk-17-jre -y

#その他
apt install vim -y
apt install tar -y
apt install htop -y
apt install nmap -y
apt install sudo -y
apt install wget -y
apt install curl -y
apt install make -y
apt install bash -y
apt install cmake -y
apt install aria2 -y
apt install ffmpeg -y
apt install screen -y
apt install dialog -y
apt install binutils -y
apt install neofetch -y
apt install apt-utils -y
apt install net-tools -y
apt install coreutils -y
apt install p7zip-full -y
apt install ninja-build -y
apt install busybox-static -y
apt install build-essential -y
apt install bash-completion -y
apt install android-tools-adb -y

apt autoremove -y
apt autoclean -y
apt clean -y
chsh -s bash
python3 -m pip install -U pip
python3 -m pip install -U youtube_dl
cat <<EOF >.config/youtube-dl/config
-o "%(title)s (by %(uploader)s).%(ext)s" -R infinite --external-downloader aria2c --external-downloader-args "-c -j16 -x16 -s16 -m0 -k1M"
EOF

adduser marme
visudo

