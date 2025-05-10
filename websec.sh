#!/bin/bash
# Script for Hyperion v3.x that performs web security test using Gilosmero (integration with CWE CVE and OWASP)
# INSTALL FIRST https://github.com/golismero/golismero
sudo bash
apt-get install python2.7 python2.7-dev python-pip python-docutils git perl nmap sslscan
cd /opt
git clone https://github.com/golismero/golismero.git
cd golismero
pip install -r requirements.txt
pip install -r requirements_unix.txt
ln -s ${PWD}/golismero.py /usr/bin/golismero
exit
# EDIT API FOR SHODAN
mkdir ~/.golismero
touch ~/.golismero/user.conf
chmod 600 ~/.golismero/user.conf
nano ~/.golismero/user.conf
# add these
[shodan:Configuration]
apikey = <INSERT YOUR SHODAN API KEY HERE>

[openvas]
host = <INSERT THE OPENVAS HOST HERE>
user = <INSERT THE OPENVAS USERNAME HERE>
*password = <INSERT THE OPENVAS PASSWORD HERE>

[spiderfoot]
url = <INSERT THE SPIDERFOOT URL HERE>
#################################################################

s=$1
j=$2

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners --script http* -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapWebApp.html
# golismero grab Nmap results, scan host found and write an HTML report:
sudo golismero scan -i usernmap.xml -o gorep.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} golly.zip usermapWebApp.html gorep.html

# Email Report and Password
echo " Golismero Report golly.zip" | mail -s "Golismero Web Scann Report for "$1" " -A golly.zip $2
echo " Your password for "$1" golly.zip is "${pass}" " | mail -s "Your golly.zip Info" $2
