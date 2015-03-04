##################### install_gugent.sh #######################

# process funtion necessary for utilizing the gugent with kickstart
function process() {
    while true; do
        /usr/bin/gugent --host=vra-iaas-2.inkysea.local --ssl --config=/usr/share/gugent/gugent.properties --script=/usr/share/gugent/site
        if [ $? -eq 0 ]; then
            break
        fi
        sleep 30
    done
}

cd /tmp/


wget -q http://vra-appserv-2.inkysea.com/agent/jre-1.7.0_72-lin64.zip
mkdir /opt/vmware-jre
unzip -d /opt/vmware-jre jre-1.7.0_72-lin64.zip

wget -q http://vra-appserv-2.inkysea.com/agent/vmware-appdirector-agent-service-vcac_6.0.0.0-0_x86_64.rpm


wget -q http://devops.inkysea.com/pub/LinuxGuestAgentPkgs/rhel6-amd64/gugent-6.2.0-103014.x86_64.rpm
rpm -i /tmp/gugent-6.2.0-103014.x86_64.rpm

rpm -i vmware-appdirector-agent-service-vcac_6.0.0.0-0_x86_64.rpm

export AXIS2C_HOME=axis2
export LD_LIBRARY_PATH=axis2/lib
export PYTHONPATH=/usr/share/gugent/site/dops

pushd /usr/share/gugent
cd /usr/share/gugent
echo | openssl s_client -connect vra-iaas-2.inkysea.local:443 2>&1 | sed -ne "/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p" > cert.pem

/usr/share/gugent/installgugent.sh vra-iaas-2.inkysea.local:443 ssl
/opt/vmware-appdirector/agent-bootstrap/vcac-register.sh -r 443 -s vra-iaas-2.inkysea.local 

# Call process function twice to execute vRA workitems
process # SetupOS
process # CustomizeOS



# run gugent and send to background so kickstart won't hang
/bin/sh /usr/share/gugent/rungugent.sh > /dev/null 2>&1 < /dev/null &

popd

##################### End install_gugent.sh ####################
