# Hyperion v4 For Parrot or Kali Linux
This is an improved and redesigned update to the discontinued Hyperion v2/v3 written by Dr. Nathan W Jones whilst as ArcadeusOPS and Inception cyber security companies. <br/>
Backend scripts used to drive results-based automated IT Security system for Davao Cyber Security. Written in Bash and Python3. Written by Nathan Jones nat@davaosecurity.com <br/>

# Usage
* Most scripts take two command line arguments, the IP address or domain name, and the email to send Reports to. For example ./server mysite.com nat@davaosecurity.com. <br/>
* Reports are in a custom directory or the local directory, which is displayed at command prompt after completion. <br/>

# Python and PowerShell
fullOSINTAPI.py - API based OSINt <br/>
exploitsuggester.py - explaoit suggestions. <br/>
hunter.py - API based Hunter tool. <br/>
iker.py - VPN analysis. <br/>
malscan.py - malware scan. <br/>
nist.py - NIST NVD tool. <br/>
phish.py - phishing tool. <br/>
pyflooder.py - Python based Denial of Service attack. <br/>
rapidscan.py - RapidScan for OSINt. <br/>
zap.py - OWASP ZAP Python script. <br/>
pythonscan.py - Python port scan. <br/>
CRLF.ps1 - batch convert CFLF to LF. <br/>

# Vulnerabilities
exploit.sh - nmap and searchsploit (exploitdb) for exploit discovery. <br/>
vuln.sh - <br/>
le.sh - Linux exploit suggester. <br/>
we.sh - Windows exploit suggester. <br/>
back.sh - tests for ShellShock and HeartBleed issues as well as testing VNC and CITRX setups for backdoors/malware. <br/>
openvas.sh -  OPENVAS vulnerability script. <br/>
unicornscan.sh - UniCorn scanner via Docker. <br/>
goby.sh - GoBuster tool for directory brute forcing. <br/>

# Firewall
firewall.sh - firewall fingerprinting and WAF detection using nmap and WAFWoof. <br/>
fw1.sh - nmap firewall bypass scans and tests <br/>

# Servers
cloud.sh - uses nmap to test any cloud server. <br/>
db.sh -  test any database server for vulnerabilities via nmap. (See webapp.sh for SQLmap tests) <br/>
ftp.sh - nmap tests for any FTP server. <br/>
mail.sh - POP mail server tests with nmap. <br/>
mail1.sh - SMTP mail server tests nmap and ismtp. <br/>
server.sh - nmap test for Linix/Windows servers in general. <br/>
win.sh -  NetBIOS, SMB, User Accounts, and backdoor tests on Windows servers. <br/>
win1.sh - performs tests on AD/LDAP Windows servers. <br/>
sshbf.sh
nmap.sh
nmap1.sh
nmap2.sh
hydra.sh
serv.sh

# Forensics
linfor.sh -  Linux forensics. <br/>

# Content Management Systems
cms.sh -  performs general CMS tests using WafWoof and Wapiti not listed below, such as SilverStripe. <br/>
cms1.sh - WordPress scans. <br/>
cms2.sh - Joomla tests. <br/>
cms3.sh - Drupal tests. <br/>
wpscan.sh
joombf.sh

# OSINT, DNS, Email Check
NATOSINT.sh -  . <br/>
fullosint.sh - . <br/>
osint.sh - . <br/>
osint1.sh - . <br/>
dns.sh <br/>
dmitry.sh <br/>
dork.sh <br/>
emailcheck.sh <br/>
finalrecon.sh <br/>
mxtool.sh <br/>
namesOSINT.sh <br/>
namesearch.sh <br/>
nmapdkim.sh <br/>
darkdig.sh <br/>
ashok.sh - OSINT recon <br/>
sherl.sh
shodan.sh
spiderfoot.sh
sub3r.sh
torbot.sh
mailcheck.sh

# Malware
mal.sh - malware attack vector detection using nmap detection methods. <br/>

# VPN
vpn.sh - performs tests on VPNs using IKE and PPTP protocols. <br/>

# DOS Attacks (Stress Testing)
DOS.sh - uses pyflooder.py to perform HTTP Flood DOS attacks. <br/>
DOS1.sh - searches for possible DOS vector attack surfaces using nmap. <br/>
dosde.sh - DOS detection

# Web Apps
webapp.sh - Web Apps tests using nmap, SQLMap, OWASP ZAP , and RapidScan. <br/>
uni.sh - uses Uniscan to discover LFI RFI and RCE vulnerabilities on Web Apps. <br/>
bw.sh - vulnerability assessment for Web Apps using OWASP BlackWidow. <br/>
websec.sh - Golismero web security scan. <br/>
DockerWorkaround.txt -  solution to running ZAP in Docker <br/>
zapattack.sh
zapstart.sh
xsser.sh
slowhttptest.sh
httpbf.sh
brutespray.sh
nikto.sh
OLDzapstart.sh
nettacker.sh

# Crypto
dr.sh - nmap scripts to test for SSL vulnerabilities of POODLE and DROWN. <br/>
sslyze.sh
dr.sh -  POODLE and SSL analysis

# Miscellaneous
cleanup.sh
delmail.sh
dosdeinstall.sh
docstop.sh
malscaninstall.sh

# txt files
passwords.txt
big.txt
commonpass.txt
commonusers.txt
dnsmap.txt
users.txt

## Ethical Notice
The original code is written by Nathan W Jones, who is not responsible for misuse of these tools. Do not use these scripts to navigate websites/devices that take part in any activity that is identified as illegal under the laws and regulations of your government. STAY LEGAL !!<br/>

## License
MIT License
Copyright (c) Davao Cyber Security

# Bugs
Send issues to info@davaosecurity.com stating nature of issue. A screenshot will help too. Thanks.

# CPD
Part of ECE/CPD Credits
