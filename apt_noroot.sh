#!/usr/bin/env -S bash
[ -p /dev/stdin ] &&set -- $@ $(cat -)

[ -n "$@" ] &&echo -e "argument missing" ;exit 1 #中身が無いとエラーになる
apt clean
apt install --download-only $@
mv /var/cache/apt/archive/*.deb ~/.local/src/
ls ~/.local/src/ |xargs -i -P$(nproc) dpkg -x {} ~/.local/ &&echo "package installed!"
rm ~/.local/src/*

