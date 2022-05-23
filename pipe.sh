#!/usr/bin/env -S bash
[ -p /dev/stdin ] &&set -- $@ $(cat -) #パイプを位置パラメータに変換

echo $@
