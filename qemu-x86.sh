#!/bin/bash

cd $(dirname $0)
read -p stop
exec qemu-x86_64-static $@
