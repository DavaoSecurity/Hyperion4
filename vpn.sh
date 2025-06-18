#!/bin/bash
# Script performs VPN tests IKE and pptp
N=$1
V=$2

# iker.py to analyse the security of the key exchange phase in IPsec based VPNs
python iker.py -v -o $1 > ik.txt
sed -i "1i IKE-Scan that checks for security flaws\n---------------------------------------" ik.txt
# VPN scan script
sudo nmap -sU -p 50, 500, 1701, 1723, 4500 --script ike-version $1 -oX uservpn.xml
xsltproc uservpn.xml -o uservpnall.html
# IKE VPN fingerprinting test; find valid transformation
cd ike-scan
ike-scan $1 --verbose  --showbackoff --patterns /usr/share/ike-scan/ike-backoff-patterns $1 > uv.txt
cat uv.txt | grep handshake > uvpn.txt
sed -i "1i IKE-SCAN Results\n-------------------" uvpn1.txt
mv uvnp1.txt /root
cd ..
# vuln vulnerability scan
sudo nmap -vv --script vuln --script vulners $1 -oX usernmap.xml
xsltproc usernmap.xml -o UNmapvpn.html
# pptp vpn scan
sudo nmap -vv -sV 50, 500, 1701, 1723, 4500 --script pptp-version $1 -oX pptp.xml
xsltproc pptp.xml -o pptp.html
# vuln vulnerability scan
sudo nmap -vv --script vuln --script vulners $1 -oX usernmap.xml
xsltproc usernmap.xml -o UrNmapVPN.html
# VPN Port check/scan
sudo nmap -sU -p- --script ike-version $1 -oX vpncheck.xml
xsltproc vpncheck.xml -o vpncheck.html
# CISCO ASA SSL VPN scan CVE2014-2128
sudo nmap -vv 50, 500, 1701, 1723, 4500 --script http-vuln-cve2014-2128 $1 -oX ciscoasa.xml
xsltproc ciscoasa.xml -o ciscoasa.html
# CISCO Anyconnect VPN scan
sudo nmap -vv 50, 500, 1701, 1723, 4500 --script http-cisco-anyconnect $1 -oX ciscoany.xml
xsltproc ciscoany.xml -o ciscoany.html
# Pulse SSL VPN scan
sudo nmap -n 50, 500, 1701, 1723, 4500 --script http-pulse_ssl_vpn -n $1 -oXpulse.xml
xsltproc pulse.xml -o pulse.html
# brute force VPN for ID's
cd ike-scan
ike-scan -P -M -A -n --id=administrator $1 > fa.txt
cat ik.txt fa.txt | grep handshake > fake.txt
sed -i "1i IKE-SCAN Fake ID Brute Force Results\n -------------------------------------" fake.txt
cat ik.txt uvpn1.txt fake.txt > outputvpnall.txt
mv fake.txt /root
cd ..
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} vpn.zip uservpnall.html UNmapvpn.html pptp.html UrNmapVPN.html vpncheck.html ciscoasa.html ciscoany.html pulse.html outputvpnall.txt

# Email Report and Password
echo " VPN Report vpn.zip" | mail -s "Detailed VPN Reports for "$1" " -A vpn.zip $2
echo " Your password for "$1" vpn.zip is "${pass}" " | mail -s "Your vpn.zip Info" $2
