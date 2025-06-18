#!/bin/bash
# Script performs NetBIOS, SMB, USer Accounts, and backdoor tests on Windows servers
G=$1
K=$2
# SMB OS discovery SMB signing check smb vulnerability scripts SMB brute force
sudo nmap -p 139, 445 --script smb-os-discovery --script smb-security-mode --script smb-vuln-* --script smb-brute -–script-args userdb=common_pass.txt,passdb=common_users.txt $1 -oX smb.xml
xsltproc smb.xml -o smb.html
# IIS web server name disclosure  MS08-067 (netapi) vulnerability check MS08-067 (netapi) vulnerability check
sudo nmap -p 80, 445 --script http-iis-short-name-brute --script smb-vuln-ms08-067 --script smb-vuln-ms08-067 $1 -oX api.xml
xsltproc api.xml -o api.html
# Netbios and MAC address lookup
sudo nmap -sU -p 137 --script nbstat $1 -oX net.xml
xsltproc net.xml -o net.html
# Enumerating user accounts Enumerating window shares
sudo nmap -p 139, 445 --script smb-enum-users --script smb-enum-shares –script-args smbusername=vagrant,smbpassword=vagrant $1 -oX enum.xml
xsltproc enum.xml -o enum.html
# Detecting shadow brokers double pulsar smb
sudo nmap -p 445 --script smb-double-pulsar-backdoor -oX pulsar.xml $1 -vv
xsltproc pulsar.xml -o pulsar.html
# rdpscan CVE-2019-0708 bluekeep vuln
#sudo ./rdpscan $userIP > rdp.txt
#cat rdp.txt | grep vulnerable > rdp1.txt
#sed -i '1i Windows SMB, RDP BlueKeep Assessment\n----------------------------------' > rdp1.txt
# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX vuln.xml
xsltproc vuln.xml -o vuln.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} windowss.zip smb.html api.html net.html enum.html pulsar.html vuln.html

# Email Report and Password
echo " SMB NetBIOS Users Report windowss.zip" | mail -s "Windows Server Report for "$1" " -A windowss.zip $2
echo " Your password for "$1" windowss.zip is "${pass}" " | mail -s "Your windowss.zip Info" $2
