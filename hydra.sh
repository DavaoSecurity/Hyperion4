#!/bin/bash
# Hyperion v4 hydra brute force https://www.freecodecamp.org/news/how-to-use-hydra-pentesting-tutorial/
# target
a=$1

# change SSH to FTP as needed
hydra -t 4 -L users.txt -P passwords.txt $1 ssh -o fp.txt
cat fp.txt | grep  'host\login\password' > foundpass.txt
sed -i '1i HYDRA Brute Force Results for '$1'\n-------------------------------' foundpass.txt

# zip
zip hydrapass.zip fp.txt foundpass.txt

# clean up
rm fp.txt foundpass.txt
