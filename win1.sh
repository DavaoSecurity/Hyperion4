#!/bin/bash
# Script performs tests on AD/LDAP on Windows devices
L=$1
A=$2
# convert IP short form
# userIP=$(dig $usIP +short)
# echo "Your IP address is: " $userIP # for testing only remove for headless operation

# find active directory; enumerate domains
sudo nmap -vv -sU -sS -sV --script smb-enum-domains.nse --script smb-enum-domains.nse -p 389, 445, U:137, T:139 $1 -oX unmap.xml
xsltproc unmap.xml -o unmapAD.html
# LDAP search
sudo sudo nmap -p 389 --script ldap-search --script-args 'ldap.username="cn=ldaptest,cn=users,dc=cqure,dc=net",ldap.password=ldaptest,ldap.qfilter=users,ldap.attrib=sAMAccountName' $1 -oX usernmap.xml
xsltproc usernmap.xml -o usernmapLDAP.html
sudo nmap -p 389 --script ldap-search --script-args 'ldap.username="cn=ldaptest,cn=users,dc=cqure,dc=net",ldap.password=ldaptest,ldap.qfilter=custom,ldap.searchattrib="operatingSystem",ldap.searchvalue="Windows *Server*",ldap.attrib={operatingSystem,whencreated,OperatingSystemServicePack}' $1 -oX umap1.xml
xsltproc umap1.xml -o umapLDAP1.html
# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX usernmap2.xml
xsltproc usernmap2.xml -o usermapvulnWIN.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} ADLDAP.zip unmapAD.html usernmapLDAP.html umapLDAP1.html usermapvulnWIN.html

# Email Report and Password
echo " AD and LDAP Windows Report ADLDAP.zip" | mail -s "AD and LDAP Report for "$1" " -A ADLDAP.zip $2
echo " Your password for "$1" ADLDAP.zip is "${pass}" " | mail -s "Your ADLDAP.zip Info" $2
