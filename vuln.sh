#!/bin/bash
# nmap vulnerability scanner using vuln, vulners and vulnscan https://geekflare.com/nmap-vulnerability-scan/

# update vulnerability and nmap databases
sudo nmap --script-update
cd /usr/share/nmap/scripts/
cd vulscan/utilities/updater/
./updateFiles.sh
cd /
clear

# user input
#echo "                  VULNERABILITY SCAN USING NMAP AND SEVERAL DATABASES.                         "
#echo " This scan uses several large vulnerability database sources such as ExploitDB, CVE and OSVDB. "
#echo "                         By ducatinat nathan@arcadeusops.pro                                   "
#echo "                                                                                  "
#echo " Will take some time as all ports and the underlying Operating System are tested. "
#echo " ZIP FILES ARE PASSWORD PROTECTED USING THE RSA 2048-bit algorithm.               "
#echo " To be on the safe side, minimum of 8 characters for the ZIP file password.       "
#echo "                                                                                         "
#echo "                                                                                         "

#read -p " Enter the Target as IP address or short URL e.g. 192.168.8.8 or example.com : " rtarg1
#echo "                                                                                         "

# user input Report name
#read -p " Enter your Report Name e.g. Report1. Saved Report will have extension .html : " rname1
#echo "                                                                                  "

# user email to send to
#read -p " Enter the email to send the Report to e.g. me@imaginet.com.ph : " remail1
#echo "                                                                                         "
#echo " The tests will run in background with limited screen output. Takes at least 10 mins.    "
a=$1
b=$2
# run vuln scans TAKES A LONG TIME
sudo nmap --script vuln -vv -Pn -p- -oX vulnv.xml $1
sudo nmap --script vulners -Pn -vv -p- -oX vulners1.xml $1
sudo nmap --script vulscan -Pn -vv -p- -oX vulnscan1.xml $1

# xml to html
xsltproc vulnv.xml -o vuln.html
xsltproc vulners1.xml -o vulners.html
xsltproc vulnscan1.xml -o vulnscan.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} vuln.zip vuln.html vulners.html vulnscan.html
echo " Your password for "$1" vuln.zip is "${pass}" " | mail -s "Your vuln.zip Info" $2
# Email Report
echo " NMAP Vulnerability Scans " | mail -s "NMAP Vulnerability Reports for "$1" " -A vuln.zip $2
#echo " Email with Password protected Zip file sent successfully to "$remail" ."
#echo " Done. Run ./vuln.sh on another target to Hack The Planet. "
