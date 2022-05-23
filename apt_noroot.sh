#!/usr/bin/env -S bash
[ -p /dev/stdin ] &&set -- $* $(cat -)

[ "$*" = "" ] &&echo -e "argument missing" &&exit 1 #中身が無いとエラーになる

apt clean
#rm ~/.local/src/*.deb
apt install --download-only "$@"
#mv /var/cache/apt/archives/*.deb ~/.local/src/
ls /var/cache/apt/archives/*.deb |xargs -i -P$(nproc) dpkg -x {} ~/.local/ &&echo "package installed!" 2>/dev/null
#rm ~/.local/src/* 2>/dev/null

