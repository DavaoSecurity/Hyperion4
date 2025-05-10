#!/bin/env bash
# Hyperion v4 dns data gathering with output to xml, text and possibly html
# install dependancies
# sudo apt install dnsrecon dnstracer dnswalk fierce dnsmap dnsenum
# target
a=$1

# explore-domain-info https://github.com/antun3s/explore-domain-info
cd explore-domain-info-master/
python3 explore-domain-info.py $1 > EDIM.txt
sed -i '1i EDIM Domain Info Results for '$1'\n-----------------------------------------' EDIM.txt
mv EDIM.txt /root/EDIM.txt
cd ..
# host dig nslookup
host -v $1 > hostls.txt
sed -i '1i host Results for '$1'\n---------------------------------' hostls.txt
dig ns $1 > digns.txt
sed -i '1i dig ns Results for '$1'\n-------------------------------' digns.txt
# nslookup host dig
nslookup -type=mx $1 > nslookmx.txt
sed -i '1i nslookup on MS Server Results for '$1'\n-------------------------------' nslookmx.txt
host -t MX $1 > hostmx.txt
sed -i '1i host on MX Server Results for '$1'\n-------------------------------' hostmx.txt
dig -t mx $1 > digmx.txt
sed -i '1i dig on Ms Server Results for '$1'\n-------------------------------' digmx.txt
# spf and dmarc
nslookup -type=txt $1 > spfr.txt
sed -i '1i SPF on MS Server Results for '$1'\n-------------------------------' spfr.txt
nslookup -type=txt _dmarc.$1 > dmarcr.txt
sed -i '1i DMARC on MS Server Results for '$1'\n-------------------------------' dmarcr.txt
# dnsrecon
# checks all name servers, MX records, SOA records, A and AAAA records, performs Top Level Domain Scan as well as brute force subdomain
dnsrecon -d $1 -D /root/dnsmap.txt -t std --xml /root/dn.xml > nd.txt
sed -i '1i DNSRECON Brute Force Results for '$1'\n-------------------------------' nd.txt
# fix stylesheet error
# xsltproc dn.xml -o dnsrecon.html
# dnstracer
# determines where a given DNS gets its information from. This is used to trace a chain of DNS servers back to the authoritative answer
dnstracer -r 3 -v $1 > nd1.txt
sed -i '1i DNSTracer Results for '$1'\n-------------------------------' nd1.txt
# dnswalk
# a simple DNS debugger which performs zone transfer scan for a specified domains, checks the database and finds all the IP address and hosts present
dnswalk -r -d $1. > nd2.txt
sed -i '1i DNSWALK Results for '$1'\n-------------------------------' nd2.txt
# fierce
# an AIO reconnaissance tool. It is a Perl script that quickly scans domain using several tactics
fierce --domain $1 > nd3.txt
sed -i '1i Fierce Results for '$1'\n-------------------------------' nd3.txt
clear
echo " DNSRECON, DNSTracer, DNSWALK and FIERCE complete. Now running DNSMAP with brute force of subdomains. "
# dnsmap
# used for brute forcing subdomains of a particular domain name
dnsmap $1 -r /root/nd4.txt
sed -i '1i DNSMAP Results for '$1'\n-------------------------------' nd4.txt
clear
echo " DNSRECON, DNSTracer, DNSWALK, FIERCE and DNSMAP complete. Now running DNSENUM and WHOIS ......"
# dnsenum
# enumerate DNS information for a particular domain and discover details like name servers and non-contiguous IP blocks
dnsenum --noreverse -o md.xml $1 > nd5.txt
sed -i '1i DNSENUM Results for '$1'\n-------------------------------' nd5.txt
# SORT OUT Stylesheet https://stackoverflow.com/questions/8845640/xsltproc-osx-not-a-stylesheet-compilation-error-but-xml-xsl-both-work-on
# whois
whois $1 >nd6.txt
sed -i '1i WHOIS Results for '$1'\n-------------------------------' nd6.txt
# discovery scan
sudo nmap -vv --script dns-* -Pn -p- -oX disc.xml $1
# file conversion
xsltproc disc.xml -o DNSdiscovery.html

# zip and clean up
cat nd.txt nd1.txt nd2.txt nd3.txt nd4.txt nd5.txt nd6.txt hostmx.txt nslookmx.txt digmx.txt sprf.txt dmarcr.txt hostls.txt digns.txt > dns0.txt
zip MyDNStxt.zip dns0.txt EDIM.txt
zip MyDNSDiscXML.zip *.xml DNSdiscovery.html dnsenum.html dnsenum1.html md.xml dn.xml
sleep 1
# *.html dnsrecon.html dnsenum.html
rm disc.xml md.xml DNSdiscovery.html nd*.txt dns0.txt nslookmxup.txt hostmx.txt nslookmx.txt digmx.txt spfr.txt dmarcr.txt nslookupmx.txt hostls.txt digns.txt EDIM.txt
