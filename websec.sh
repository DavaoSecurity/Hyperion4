#!/bin/bash
# Script for Hyperion v4 that performs web security test using Gilosmero (integration with CWE CVE and OWASP)
# INSTALL FIRST https://github.com/golismero/golismero
#sudo bash
#apt-get install python2.7 python2.7-dev python-pip python-docutils git perl nmap sslscan
#cd /opt
#git clone https://github.com/golismero/golismero.git
#cd golismero
#pip install -r requirements.txt
#pip install -r requirements_unix.txt
#ln -s ${PWD}/golismero.py /usr/bin/golismero
#exit
# EDIT API FOR SHODAN
#mkdir ~/.golismero
#touch ~/.golismero/user.conf
#chmod 600 ~/.golismero/user.conf
#nano ~/.golismero/user.conf
# add these
[shodan:Configuration]
apikey = <INSERT YOUR SHODAN API KEY HERE>

[openvas]
host = <INSERT THE OPENVAS HOST HERE>
user = <INSERT THE OPENVAS USERNAME HERE>
*password = <INSERT THE OPENVAS PASSWORD HERE>

[spiderfoot]
url = <INSERT THE SPIDERFOOT URL HERE>

s=$1 # target

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners --script http* -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapWebApp.html
# golismero grab Nmap results, scan host found and write an HTML report:
sudo golismero scan -i usernmap.xml -o gorep.html

# zip
zip golly.zip usermapWebApp.html gorep.html

# clean up
rm usermapWebApp.html gorep.html usernmap.xml
