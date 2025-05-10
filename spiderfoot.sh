#!/bin/bash
# Hyperion v4 https://intel471.com/attack-surface-documentation
# https://github.com/smicallef/spiderfoot
# can us -m to run specific modules for a more targeted scan
h=$1 # target
cd spiderfoot-4.0
python3 ./sf.py -s $1 -o tab > sfoot.txt
mv sfoot.txt /root
cd ..
# zip
zip sf.zip sfoot.txt # sf.html

# clean up
rm sfoot.txt sf.zip
