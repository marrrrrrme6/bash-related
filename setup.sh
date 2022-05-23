#!/usr/bin/env -S bash
#リポジトリのアップデート
if [[ $(whoami) != root ]];then
    echo 'Use this as root (sudo)!'
    exit 1
fi

_ver() {
    echo "version:β0.1"
    exit 0
}

_usage() {
cat << EOF
$(figlet $0)

    -v --version Show version
    -h --help Get help
    -g --gcc install gcc
    -p --python install python
    -j --java install java
    -u --gui install java
EOF
    exit 0
}

_gcc() {
    #gcc関係
    apt install gcc-i686-linux-gnu -y
    apt install gcc-x86-64-linux-gnu -y
    apt install gcc-arm-linux-gnueabi -y
    apt install gcc-aarch64-linux-gnu -y
}

_python() {
    #python関係
    apt install python3 -y
    apt install python3-full -y
    apt install python3-pip -y
    apt install python3-sphinx -y
}

_java() {
    #Java関係
    apt install openjdk-8-jre -y
    apt install openjdk-17-jre -y
}

_gui() {
    #gui関係
    apt install openbox -y
    apt install tightvncserver -y
}

if [[ $# = 0 ]];then 
    _usage
fi

apt update -y
apt upgrade -y

while (( $# > 0 )); do
    case $1 in
        -*)
            if [[ "$1" =~ "-version" || "$1" =~ "v" ]];then
                _ver
            fi
            if [[ "$1" =~ "-help" || "$1" =~ "h" ]] ;then
                _usage
            fi
            if [[ "$1" =~ "-gcc" || "$1" =~ "g" ]] ;then
                _gcc
            fi
            if [[ "$1" =~ "-python" || "$1" =~ "p" ]] ;then
                _python
            fi
            if [[ "$1" =~ "-java" || "$1" =~ "j" ]] ;then
                _java
            fi
            if [[ "$1" =~ "-gui" || "$1" =~ "u" ]] ;then
                _gui
            fi
            shift
            ;;
        *)
            shift
            ;;
    esac
done

<<COMOUT
. /etc/os-release
dpkg --add-architecture amd64
cat <<EOF >>/etc/apt/sources.list                                                       deb [arch=amd64] http://jp.archive.ubuntu.com/ubuntu $UBUNTU_CODENAME main universe multiverse                                                                                  deb [arch=amd64] http://jp.archive.ubuntu.com/ubuntu $UBUNTU_CODENAME-updates main universe multiverse                                                                          deb [arch=amd64] http://jp.archive.ubuntu.com/ubuntu $UBUNTU_CODENAME-security main universe multiverse
EOF

apt install vim -y
apt install tar -y
apt install htop -y
apt install nmap -y
apt install sudo -y
apt install wget -y
apt install curl -y
apt install make -y
apt install bash -y
apt install file -y
apt install cmake -y
apt install aria2 -y
apt install ffmpeg -y
apt install screen -y
apt install dialog -y
apt install figlet -y
apt install binutils -y
apt install neofetch -y
apt install apt-file -y
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
chsh -s /usr/bin/bash
#python3 -m pip install -U pip
python3 -m pip install -U youtube_dl
cat <<EOF >.config/youtube-dl/config
-f bestvideo+bestaudio -o "%(title)s (by %(uploader)s).%(ext)s" -R infinite --external-downloader aria2c --external-downloader-args "-c -j16 -x16 -s16 -m0 -k1M"
EOF
apt_fast_installation() {
if ! type aria2c >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y aria2
fi
wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast -O /usr/local/sbin/apt-fast
chmod +x /usr/local/sbin/apt-fast
if ! [[ -f /etc/apt-fast.conf ]]; then
    wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf -O /etc/apt-fast.conf
fi
}

if [[ "$EUID" -eq 0 ]]; then
    apt_fast_installation
else
    type sudo >/dev/null 2>&1 || { echo "sudo not installed, change into root context" >&2; exit 1; }
    DECL="$(declare -f apt_fast_installation)"
    sudo bash -c "$DECL; apt_fast_installation"
fi


adduser marme
visudo
COMOUT
