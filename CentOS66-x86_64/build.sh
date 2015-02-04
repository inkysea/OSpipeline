#!/bin/bash

cd `dirname $0`

cp CentOS66-x86_64-ks.cfg CentOS66-x86_64/ks.cfg

mkisofs -r -T -J -V "CENTOS6X8664" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o bin/CentOS6-x86_64.iso CentOS66-x86_64

rm CentOS66-x86_64/ks.cfg

mkdir -p bin
cp CentOS66-x86_64-ks.cfg bin/
cp ../post-installation/* bin/
