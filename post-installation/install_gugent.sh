##################### install_gugent.sh #######################
cd /tmp/
wget http://devops.inkysea.com/pub/LinuxGuestAgentPkgs/rhel6-amd64/gugent-6.2.0-103014.x86_64.rpm
rpm -i /tmp/gugent-6.2.0-103014.x86_64.rpm
export AXIS2C_HOME=axis2
export PYTHONPATH=/usr/share/gugent/site/dops
pushd /usr/share/gugent
cd /etc/sysconfig
mv selinux selinux.old
#wget http://webserver/selinux
cd /usr/share/gugent
echo | openssl s_client -connect vra-iaas-2.inkysea.local:443 2>&1 | sed -ne "/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p" > cert.pem
/usr/share/gugent/installgugent.sh vra-iaas-2.inkysea.local:443 ssl
/usr/share/gugent/rungugent.sh &
process # SetupOS
process # CustomizeOS
popd

##################### End install_gugent.sh ####################
