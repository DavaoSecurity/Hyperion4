#!/bin/bash
# !!!!    FOR NETWORKS ONLY    !!!!
# Hyperion v4https://github.com/OWASP/Nettacker?tab=readme-ov-file   https://github.com/OWASP/Nettacker/wiki/Usage
f=$1 # file target(s) list, separate with ,

cd Nettacker
python3 nettacker.py -t 10 -v -i $1 -s -m all -o netres.html
mv netres.html /root

# zip
zip nettacker.zip netres.html

# clean up
rm netres.html
