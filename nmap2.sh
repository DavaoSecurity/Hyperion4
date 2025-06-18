#!/bin/bash
sudo nmap --script-update
sudo nmap --script-updatedb
#echo " This will email several nmap Reports - Aggressive, Firewall, HTTP, Vulnerabilities.                         "
#echo " All Reports are in HTML Formats in a password protected Zip File. All Scans probe ALL TCP Ports.            "
#echo " EDIT  nmap.sh to uncomment the desired scan AND output file that you want. Press CTL+C now to do this.      "
#echo "                                                                                                             "
#sleep 5
#read -p " Enter the Target e.g. example.com OR the IP address e.g. 192.168.2.4 : " rtarg
#echo "                                                                                 "
#read -p " Enter the email to send the Report to e.g. me@imaginet.com.ph : " remail
#echo "                                                                              "
#echo " The nmap scans will take some time ......................................... "
#echo "                                                                              "
a=$1
b=$2
# aggressive scan
# sudo nmap -vv -A -p- -oX agg.xml $rtarg

# detect firewall settings
sudo nmap -vv -sA -p- -Pn -oX firew.xml $1

# http scan
# sudo nmap -vv --script http* -p- -oX http.xml $rtarg

# firewalk scan
sudo nmap -vv --script firewalk -p- -Pn -oX firewalk.xml $1

# basic vulnerability scan
# sudo nmap -vv -p- --script vuln -oX vuln.xml $rtarg

# all ports UDP and TCP
# sudo nmap -sU -sT -p0-65535 -oX allports.xml $rtarg

# file conversion
# xsltproc agg.xml -o AggressiveScan.html
xsltproc firew.xml -o Firewall.html
# xsltproc http.xml -o HTTP.html
# xsltproc vuln.xml -o Vulns.html
# xsltproc allports.xml -o AllPortsUDPTCP.html
xsltproc firewalk.xml -o FireWalk.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} firewall.zip Firewall.html FireWalk.html
echo " Your password for "$1" firewall.zip is "${pass}" " | mail -s "Your firewall.zip Info" $2
# Add Firewall.html or ALLPortsUDPTCP.html as required

# Email Report
echo " Firewall NMAP Scan firewall.zip" | mail -s "Firewall NMAP Scan for "$1" " -A firewall.zip $2

#echo " Email and Password protected Zip file sent successfully to "$remail" ."
#rm *.html
#rm *.xml
#clear
#echo " Done. Run ./nmap.sh on another target to Hack The Planet. "
#echo " PLEASE NOTE:                                           "
#echo " If email did not arrive, open Powershell and type..... "
#echo " scp root@194.163.139.59:/root/nmapreport.html C:\Users\Nathan\Desktop "
#echo " Change nmapreport.html to the name input, and change Nathan to your Windows User name. "
#echo " scp will securely download the Nmap .html files to your Windows Desktop. "
