#!/bin/bash
# Hyperion v3 email MXTOOLS EDIT domains.txt in directory MxToolbox-API---Python
# cd MxToolbox-API---Python
# nano domains.txt
# target
t=$1

cd MxToolbox-API---Python
python3 mxcall.py > emcheck.txt
sed -i '1i MxToolbox Email Settings Results\n----------------------------' emcheck.txt
mv emcheck.txt /root
cd ..

# clean up
rm emcheck.txt
