#!/bin/bash
# Hyperion v4 Script performs tests on AD/LDAP on Windows devices
L=$1 # target

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
zip ADLDAP.zip unmapAD.html usernmapLDAP.html umapLDAP1.html usermapvulnWIN.html

# clean up
rm unmapAD.html usernmapLDAP.html umapLDAP1.html usermapvulnWIN.html unmap.xml usernmap.xml umap1.xml usernmap2.xml
