#!/bin/bash
# Hyperion 4 Ubuntu Snap CVEScan used for VAPT on internal assets
# NOT used on external IP target

cvescan -v -p all > cvescan.txt
sed -i '1i CVEScan Output\--------------------' cvescan.txt

zip joomla.zip outputcms2.txt whatcms2.html
rm cvescan.txt cvescan.zip
