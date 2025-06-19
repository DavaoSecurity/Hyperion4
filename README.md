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
server.sh - nmap test for Linux/Windows servers in general. <br/>
win.sh -  NetBIOS, SMB, User Accounts, and backdoor tests on Windows servers. <br/>
win1.sh - performs tests on AD/LDAP Windows servers. <br/>
sshbf.sh - SSH brute force. <br/>
nmap.sh - general NMAP scan. <br/>
nmap1.sh - NMAP HTTP scripts. <br/>
nmap2.sh - very aggressive NMAP scans. <br/>
hydra.sh - HYDRA brute force scripts. <br/>
serv.sh - local server enumeration. <br/>

# Forensics
linfor.sh -  Linux forensics. <br/>

# Content Management Systems
cms.sh -  performs general CMS tests using WafWoof and Wapiti not listed below, such as SilverStripe. <br/>
cms1.sh - WordPress scans. <br/>
cms2.sh - Joomla tests. <br/>
cms3.sh - Drupal tests. <br/>
wpscan.sh - WordPress tests using WPScan. <br/>
joombf.sh - Joomla brute force. <br/>

# OSINT, DNS, Email Check
NATOSINT.sh -  a basic tool for OSINT. <br/>
fullosint.sh - a comprehensice tool for OSINT. <br/>
osint.sh - dnseum script. <br/>
osint1.sh - for social media. <br/>
dns.sh - DNs enumeration. <br/>
dmitry.sh - DMITRY tool for OSINt. <br/>
dork.sh - Google DORKS on a target. <br/>
emailcheck.sh - check email for errors in SPF, DKIM and DMARC. <br/>
finalrecon.sh - comprehensive FINALRECON too for a very detailed OSINT analysis. <br/>
mxtool.sh - uing MXTOOL for email analysis. <br/>
namesOSINT.sh - OSINT on a name. <br/>
namesearch.sh - OSINT on a person's name. <br/>
nmapdkim.sh - nmap script to assess DKIM email setup. <br/>
darkdig.sh - search the Dark Web for OSINT threads. <br/>
ashok.sh - OSINT recon using ASHOK. <br/>
sherl.sh - Sherlock too for social media. <br/>
shodan.sh - SHODAN tool, use own API. <br/>
spiderfoot.sh - a detailed tool using SpiderFoot, with great Reporting and Graphics. <br/>
sub3r.sh - sublister tool. <br/>
torbot.sh - use the TOR for OSINT. <br/>
mailcheck.sh - check email configuration e.g. SPF, DKIM and DMARC. <br/>

# Malware
mal.sh - malware attack vector detection using nmap detection methods. <br/>

# VPN
vpn.sh - performs tests on VPNs using IKE and PPTP protocols. <br/>

# DOS Attacks (Stress Testing)
DOS.sh - uses pyflooder.py to perform HTTP Flood DOS attacks. <br/>
DOS1.sh - searches for possible DOS vector attack surfaces using nmap. <br/>
dosde.sh - DOS detection. <br/>

# Web Apps
webapp.sh - Web Apps tests using nmap, SQLMap, OWASP ZAP , and RapidScan. <br/>
uni.sh - uses Uniscan to discover LFI RFI and RCE vulnerabilities on Web Apps. <br/>
bw.sh - vulnerability assessment for Web Apps using OWASP BlackWidow. <br/>
websec.sh - Golismero web security scan. <br/>
DockerWorkaround.txt -  solution to running ZAP in Docker <br/>
zapattack.sh - OWASP ZAP Attack Mode in Docker. <br/>
zapstart.sh - OWASP ZAP Normal Mode in Docker. <br/>
xsser.sh - Cross Site script analysis. <br/>
slowhttptest.sh - DOS Slow Loris attack on HTTP. <br/>
httpbf.sh - HTTP attack. <br/>
brutespray.sh - Password spraying. <br/>
nikto.sh - NIKTO webserver alanysis. <br/>
OLDzapstart.sh - previous OWASP ZAP that may work on older machines. <br/>
nettacker.sh - NETTACKER scanner. <br/>

# Crypto
dr.sh - nmap scripts to test for SSL vulnerabilities of POODLE and DROWN. <br/>
sslyze.sh - analyse SSL setup. <br/>
dr.sh -  POODLE and SSL analysis. <br/>

# Miscellaneous
cleanup.sh - cleanup script. Use with caution. <br/>
delmail.sh - delete root mail. <br/>
dosdeinstall.sh - dosde.sh installation. <br/>
docstop.sh - Docker stop and cleanup. <br/>
malscaninstall.sh - malscan.sh installation. <br/>

# txt files for brute forcing
passwords.txt <br/>
big.txt <br/>
commonpass.txt <br/>
commonusers.txt <br/>
dnsmap.txt <br/>
users.txt <br/>

## Ethical Notice
The original code is written by Nathan W Jones, who is not responsible for misuse of these tools. Do not use these scripts to navigate websites/devices that take part in any activity that is identified as illegal under the laws and regulations of your government. STAY LEGAL !!<br/>

## License
MIT License
Copyright (c) Davao Cyber Security

# Bugs
Send issues to info@davaosecurity.com stating nature of issue. A screenshot will help too. Thanks.  <br/>

# CPD
Part of ECE/CPD Credits  <br/>
