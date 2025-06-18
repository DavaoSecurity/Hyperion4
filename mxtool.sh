#!/bin/bash
# EDIT domains.txt in directory MxToolbox-API---Python
# cd MxToolbox-API---Python
# nano domains.txt

t=$1
n=$2

cd MxToolbox-API---Python
python3 mxcall.py > emcheck.txt
sed -i '1i MxToolbox Email Settings Results\n----------------------------' emcheck.txt
mv emcheck.txt /root
cd ..

# Email Report and Password
echo " EmailCheck Using MXtoolbox " | mail -s "DKIM SPF DMARC Check " -A emcheck.txt $2
sleep 5
rm emcheck.txt
