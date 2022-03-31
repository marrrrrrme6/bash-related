#!/usr/bin/env -S bash
qemu-system-x86_64 -name qemu-x86_64 -smp `nproc` -m 2048 -vnc 0.0.0.0:0 -boot nc -drive file='./mini.iso',media='cdrom' $@
#qemu-system-i386 -name qemu-x86 -smp `nproc` -m 2048 -vnc 0.0.0.0:0 -boot ncd -drive file='',format='' $@ 
#qemu-system-arm -name qemu-arm -smp `nproc` -m 2048 -vnc 0.0.0.0:0 -boot ncd -drive file='',format='' $@
#qemu-system-aarch64 -machine virt -name qemu-arm64 -smp `nproc` -m 2048 -vnc 0.0.0.0:0 -boot ncd -cdrom 'ubuntu-20.04.3-live-server-arm64.iso' $@
#qemu実行ファイル
