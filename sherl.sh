#!/bin/bash
h=$1
v=$2
u=$3 # username
# docker build -t mysherlock-image .
# docker run --rm -t -v "$PWD/results:/opt/sherlock/results" mysherlock-image -o sherlock.txt $3
# zip
cd sherlock
python3 sherlock $3 > sherl.txt

# pass=$(openssl rand -base64 6)
zip sherlock.zip sherlock.txt
# echo " Your password for "$1" sherlock.zip is "${pass}" " | mail -s "Your sherlock.zip Info" $2
# Email Report
echo " Sherlock OSINT " | mail -s "Sherlock Report for "$1" " -A sherlock.zip $2
sleep 5
rm sherlock.zip sherl.txt
cd ..
