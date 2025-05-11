#!/bin/bash
# Hyperion v4 https://www.kali.org/tools/xsser/
h=$1 # target

cd xsser
xxser -all $1 -v -s --Da --xml=xsser.xml
xsltproc xsser.xml -o xsser.html
mv xsser.xml xsser.html /root
cd ..
# zip
zip xxserr.zip xsser.html xsser.xml

# clean up
rm xsser.xml xsser.html
