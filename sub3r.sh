#!/bin/bash
h=$1 # target

# Hyperion 4 git clone https://github.com/aboul3la/Sublist3r.git
# sudo pip install -r requirements.txt
cd Sublist3r
python sublist3r.py -e google,yahoo,virustotal -d $1 -o sublist.txt
# zip

zip sublist.zip sublist.txt
# clean up
rm sublist.zip sublist.txt
cd ..
