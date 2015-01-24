cd /tmp/
wget http://devops.inkysea.com/pub/VMwareTools-9.4.5-1598834.tar.gz
tar -zxvf VMwareTools-9.4.5-1598834.tar.gz 
cd vmware-tools-distrib
./vmware-install.pl -d
cd /tmp/
rm /tmp/VMwareTools-9.4.5-1598834.tar.gz
rm -rf /tmp/vmware-tools-distrib
