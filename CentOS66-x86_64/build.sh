#!/bin/bash

cd `dirname $0`

cp CentOS66-x86_64-ks.cfg CentOS66-x86_64/ks.cfg

mkdir -p bin
rm -rf bin/*

mkisofs -r -T -J -V "CENTOS6X8664" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o bin/CentOS6-x86_64.iso CentOS66-x86_64

#rm CentOS66-x86_64/ks.cfg


cp CentOS66-x86_64-ks.cfg bin/

cd ..

tar -cf CentOS66-x86_64/bin/scripts.tar post-installation/*.sh
gzip CentOS66-x86_64/bin/scripts.tar
