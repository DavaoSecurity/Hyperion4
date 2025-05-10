#!/bin/bash
# Hyperion v4 https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
L=$1 # target

# http
# change port if needed
nmap -p 2 --script ssh-brute --script-args userdb=users.txt,passdb=passwords.txt -oX sshbf.xml $1
xsltproc sshbf.xml -o sshBrute.html

# zip
zip sshBF.zip sshBrute.html

# clean up
rm sshbf.xml sshBrute.html
