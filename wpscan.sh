#!/bin/bash
# Hyperion v4 wpscan https://github.com/wpscanteam/wpscan
a=$1 # target

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
zip wpscan.zip wpuser.html wp100users.html plugsthemes.html wpvuln.html brutepass.html
# clan up
rm wpuser.html wp100users.html plugsthemes.html wpvuln.html brutepass.html *.json
