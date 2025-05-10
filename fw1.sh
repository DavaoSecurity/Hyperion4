#!/bin/bash
# Hyperion v4 furtherScript for nmap firewall bypass scans and tests
# target
i=$1
# nmap vuln on firewall
sudo nmap -vv -p - $1 --script vuln --script vulners -oX usernmap.xml
xsltproc usernmap.xml -o usermapfw.html
# are firewall filters and rules performing as intended? simple Nmap firewall audit
sudo nmap -vv -p - -sA -n $1 -oX fwaudit.xml
xsltproc fwaudit.xml -o fwaudit.html
# The above Nmap TCP ACK scan (-sA) will establish whether packets can pass through your firewall unfiltered. To speed up the scan, the –n
# option can be used to prevent reverse DNS resolution on the active IP addresses it finds. I would also use the –oA output option so you
# create a searchable file as well as an XML file to use for record keeping and reporting. You can use these output files to review the
# traffic flow through any unfiltered ports and then modify your firewall rule sets where necessary.
# One mistake many administrators make when allowing traffic through their firewall is trusting traffic based simply on its source port number,
# such as DNS replies from port 53 or FTP from port 20. To test firewall rules, however, you can use most of Nmap's TCP scans, including the
# SYN scan, with the spoof source port number option (--source-port or abbreviated just to –g). By providing the port number, the network
# mapper will send packets from that port where possible. The following example will run an FIN scan, which will use a spoofed source port
# number of 25 (SMTP) and save the output to file firewallreport.txt. Now you can see if a particular port is allowing all traffic through:
# FIN scan
sudo nmap -p - -sF -g 25 $1 -oX fin.xml
xsltproc fin.xml -o fin.html
# fragmented traffic bypass firewall
sudo nmap -sS -p - --scan-delay 500 -f $1 -oX frag.xml
xsltproc frag.xml -o frag.html

# zip
# pass=$(openssl rand -base64 6)
# zip --password ${pass} firewallB.zip fin.html frag.html usermapfw.html fwaudit.xml
zip firewallB.zip fin.html frag.html usermapfw.html fwaudit.html

# clean up
rm fin.html fin.xml frag.xml frag.html usermapfw.html fwaudit.xml usernmap.xml
