#!/usr/bin/env bash
# Hyperion v4OSINT1
# INSTALL FIRST https://github.com/twintproject/twint https://github.com/sherlock-project/sherlock https://github.com/alpkeskin/mosint
#
n=$1 # Username to search
s=$2 # user email to search

# twint
twint -u $uname --followers --user-full --email --phone -o twint.txt
sed -i -e '1iTwint files\' twint.txt
sed -i -e '2i***************************\' twint.txt
# Sherlock see https://github.com/sherlock-project/sherlock#installation
cd sherlock
sherlock --verbose $uname $umail --xlsx sherly.xlsx
mv sherly.xlsx /root
cd ..
# python3 sherlock user1 user2 user3
# Accounts found will be stored in an individual text file with the corresponding username (e.g user123.txt).
# MOSINT see https://www.geeksforgeeks.org/mosint-osint-tool-for-emails-in-kali-linux/
# MOSINT API keys
# mosint set hunter <18a27fba1f51ed59e52d49fd483c6dbcad020bda>
# mosint set emailrep <emailrep.io API key>
# mosint set intelx <af057190-f051-4041-a619-52cebcd55f43>
# mosint set psbdmp <06854e5ed04880d9739c87beee73bbd2>
# mosint set breachdirectory <58fff0d5d5msh8b2308b757609ebp1dd419jsn2dbc042b4e27>
#
cd mosint
mosint $umail > mosint.txt
sed -i -e '1iMOSINT .txt files\' mosint.txt
sed -i -e '2i***************************\' mosint.txt
mv mosint.txt /root
cd ..
# socan
cd social-analyzer
python3 app.py --username $1 > socan.txt
sed -i -e '1iSocial analyser .txt files\' socan.txt
sed -i -e '2i***************************\' socan.txt
mv socan.txt /root
cd ..

cat *.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i******************************************************\' allrep.txt

# zip
zip OSINT1.zip allrep.txt sherly.xlsx

# Email Report and Password
rm allrep.txt sherly.xlsx mosint.txt sherly.xlsx
cd ..
