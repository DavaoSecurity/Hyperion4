#!/bin/bash
# wpscan https://github.com/wpscanteam/wpscan
a=$1
b=$2
docker pull wpscanteam/wpscan
docker run -it --rm wpscanteam/wpscan --url https://$1/ --enumerate u --output wpuser.json
docker run -it --rm wpscanteam/wpscan --url https://$1/ --enumerate u1-100 --output wp100users.json
docker run -it --rm wpscanteamwpscan --url https://$1 --enumerate ap,at --output plugsthemes.json
docker run -it --rm wpscanteam/wpscan --url https://$1 --enumerate vp,vt,vt,tt --output wpvuln.json
docker run -it --rm wpscanteam/wpscan --url https://$1 --passwords passwords.txt --usernames users.txt --output brutepass.json
# json convert https://github.com/kellyjonbrazil/jtbl   <JSON Data> | jtbl [OPTIONS] pip3 install jtbl
wpuser.json | jtbl -h wpuser.html
wp100users.json | jtbl -h wp100users.html
plugsthemes.json | jtbl -h plugthemes.html
wpvuln.json | jtbl -h wpvuln.html
brutepass.json | jtbl -h brutepass.html
# zip and password
pass=$(openssl rand -base64 6)
zip --password ${pass} wpscan.zip wpuser.html wp100users.html plugsthemes.html wpvuln.html brutepass.html
echo " Your password for "$1" wpscan.zip is "${pass}" " | mail -s "Your wpscan.zip Info" $2
echo " WPScan Enumeration " | mail -s " WPScan Vulnerabilities  "$1" " -A wpscan.zip $2
