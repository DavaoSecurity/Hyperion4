#!/bin/bash
h=$1
v=$2
# git clone https://github.com/aboul3la/Sublist3r.git
# sudo pip install -r requirements.txt
cd Sublist3r
python sublist3r.py -e google,yahoo,virustotal -d $1 -o sublist.txt
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} sublist.zip sublist.txt
echo " Your password for "$1" sublist.zip is "${pass}" " | mail -s "Your sublist.zip Info" $2
# Email Report
echo " sublist3r Domain Name " | mail -s "sublist3r Report for "$1" " -A sublist.zip $2
rm sublist.zip sublist.txt
cd ..
