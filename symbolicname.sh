#!/usr/bin/env -S bash
[ -p /dev/stdin ] &&set $@ $(cat -)

base=$(basename $0)
_ls() {
    ls $@
}

_cat() {
    cat $@
}

_$base $@ #実行名参照
