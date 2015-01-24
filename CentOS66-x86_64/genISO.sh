#!/bin/bash


genisoimage -r -T -J -V "CENTOS6X8664" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ISO/centOS6-x86_64.iso CentOS66-x86_64/
