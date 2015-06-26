##################### install_gugent.sh #######################

# process funtion necessary for utilizing the gugent with kickstart
function process() {
    while true; do
        /usr/bin/gugent --host=<--VRA_IAAS_FQDN--> --ssl --config=/usr/share/gugent/gugent.properties --script=/usr/share/gugent/site
        if [ $? -eq 0 ]; then
            break
        fi
        sleep 30
    done
}

cd /tmp/


wget -q http://<--VRA_APPS_FQDN-->/agent/jre-1.7.0_72-lin64.zip
mkdir /opt/vmware-jre

unzip -d /opt/vmware-jre jre-1.7.0_72-lin64.zip


wget -q http://<--VRA_APPS_FQDN-->/agent/vmware-appdirector-agent-service-vcac_6.0.0.0-0_x86_64.rpm

wget --no-check-certificate -q https://<--VRA_FQDN-->:5480/installer/LinuxGuestAgentPkgs.zip

unzip -o /tmp/LinuxGuestAgentPkgs.zip

rpm -i /tmp/LinuxGuestAgentPkgs/rhel6-amd64/gugent-*.rpm

rpm -i vmware-appdirector-agent-service-vcac_6.0.0.0-0_x86_64.rpm

export AXIS2C_HOME=axis2
export LD_LIBRARY_PATH=axis2/lib
export PYTHONPATH=/usr/share/gugent/site/dops

pushd /usr/share/gugent
cd /usr/share/gugent
echo | openssl s_client -connect <--VRA_IAAS_FQDN-->:443 2>&1 | sed -ne "/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p" > cert.pem

/usr/share/gugent/installgugent.sh <--VRA_IAAS_FQDN-->:443 ssl
/opt/vmware-appdirector/agent-bootstrap/vcac-register.sh -r 443 -s <--VRA_IAAS_FQDN-->

# Call process function twice to execute vRA workitems
process # SetupOS
process # CustomizeOS



# run gugent and send to background so kickstart won't hang
/bin/sh /usr/share/gugent/rungugent.sh > /dev/null 2>&1 < /dev/null &

popd

##################### End install_gugent.sh ####################
