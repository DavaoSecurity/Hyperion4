#!/bin/bash
# https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
L=$1
Z=$2

# http
# change port if needed
nmap -p 2 --script ssh-brute --script-args userdb=users.txt,passdb=passwords.txt -oX sshbf.xml $1
xsltproc sshbf.xml -o sshBrute.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} sshBF.zip sshBrute.html

# Email Report and Password
echo " SH Brute sshBF.zip" | mail -s "SH BF Report for "$1" " -A sshBF.zip $2
echo " Your password for "$1" sshBF.zip is "${pass}" " | mail -s "Your sshBF.zip Info" $2
