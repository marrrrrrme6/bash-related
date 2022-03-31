#!/usr/bin/env -S bash
[ -p /dev/stdin ] &&set $@ $(cat -)
_ls() {
    ls $@
}

_cat() {
    cat $@
}


_$(basename $0) $@ #実行名参照
