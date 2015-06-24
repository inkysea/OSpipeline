#!/bin/bash

cd `dirname $0`

PKG_LOCATION = $1
PREP_SCRIPT_LOCATION = $2
VRA_FQDN = $3
VRA_APPS_FQDN = $4
VRA_IAAS_FQDN = $5

cp CentOS66-x86_64-ks.cfg CentOS66-x86_64/ks.cfg
sed -i 's/<--PKG_LOCATION-->/${PKG_LOCATION}/g' CentOS66-x86_64/ks.cfg
sed -i 's/<---VRA_FQDN-->/${VRA_FQDN}/g' CentOS66-x86_64/ks.cfg

mkdir -p bin
rm -rf bin/*

mkisofs -r -T -J -V "CENTOS6X8664" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o bin/CentOS6-x86_64.iso CentOS66-x86_64


cp CentOS66-x86_64-ks.cfg bin/

cd ..

find post-installation/ -type f -exec sed -i 's/<--VRA_FQDN-->/${VRA_FQDN}/g' {} \;
find post-installation/ -type f -exec sed -i 's/<--VRA_APPS_FQDN-->/${VRA_APPS_FQDN}/g' {} \;
find post-installation/ -type f -exec sed -i 's/<--VRA_IAAS_FQDN-->/${VRA_IAAS_FQDN}/g' {} \;

tar -cf CentOS66-x86_64/bin/scripts.tar post-installation/*.sh
gzip CentOS66-x86_64/bin/scripts.tar
