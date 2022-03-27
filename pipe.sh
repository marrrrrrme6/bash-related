#!/usr/bin/env bash
[ -p /dev/stdin ] &&set $@ $(cat -)

echo "$@"
