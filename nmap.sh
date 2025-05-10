#!/bin/bash
sudo nmap --script-update
sudo nmap --script-updatedb
#echo " This will email nmap Reports - Aggressive                                                                   "
#echo " All Reports are in HTML Formats in a password protected Zip File. All Scans probe ALL open Ports.            "
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
sudo nmap -vv -sT -sU -A -Pn -p- -oX agg.xml $1

# file conversion
xsltproc agg.xml -o AggressiveScan.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} nmap.zip AggressiveScan.html 

# Email Report and Password
echo " Aggressive NMAP Scan nmap.zip" | mail -s "Aggressive NMAP Scan Report for "$1" " -A nmap.zip $2
echo " Your password for "$1" nmap.zip is "${pass}" " | mail -s "Your nmap.zip Info" $2

#echo " Email and Password protected Zip file sent successfully to "$2" ."
#clear
#echo " Done. Run ./nmap.sh on another target to Hack The Planet. "
#echo " PLEASE NOTE:                                           "
#echo " If email did not arrive, open Powershell and type..... "
#echo " scp root@194.163.139.59:/root/nmapreport.html C:\Users\Nathan\Desktop "
#echo " Change nmapreport.html to the name input, and change Nathan to your Windows User name. "
#echo " scp will securely download the Nmap .html files to your Windows Desktop. "
