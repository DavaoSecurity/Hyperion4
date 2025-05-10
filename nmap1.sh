#!/bin/bash
sudo nmap --script-update
sudo nmap --script-updatedb
#echo " This will email Reports - HTTP                                                                              "
#echo " All Reports are in HTML Formats in a password protected Zip File. All Scans probe ALL TCP Ports.            "
#echo " EDIT  nmap.sh to uncomment the desired scan AND output file that you want. Press CTL+C now to do this.      "
#echo " Use the -Pn switch.                                                                                         "
#sleep 5
#read -p " Enter the Target e.g. example.com OR the IP address e.g. 192.168.2.4 : " rtarg
#echo "                                                                                 "
#read -p " Enter the email to send the Report to e.g. me@imaginet.com.ph : " remail
#echo "                                                                              "
#echo " The nmap scans will take some time ......................................... "
#echo "                                                                              "
a=$1
b=$2
# http scan
nmap -vv -p- -Pn --script http* -oX web.xml $1

# file conversion
xsltproc web.xml -o web.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} nmap1.zip web.html
echo " Your password for "$1" nmap1.zip is "${pass}" " | mail -s "Your nmap1.zip Info" $2

# Email Report
echo " Web Server NMAP Scan nmap1.zip" | mail -s "Web Server NMAP Scan for "$1" " -A nmap1.zip $2
#echo " Email and Password protected Zip file sent successfully to "$2" ."
#rm *.html
#rm *.xml
#clear
#echo " Done. Run ./nmap.sh on another target to Hack The Planet. "#echo " PLEASE NOTE:                                           "
#echo " If email did not arrive, open Powershell and type..... "
#echo " scp root@194.163.139.59:/root/nmapreport.html C:\Users\Nathan\Desktop "
#echo " Change nmapreport.html to the name input, and change Nathan to your Windows User name. "
#echo " scp will securely download the Nmap .html files to your Windows Desktop. "
