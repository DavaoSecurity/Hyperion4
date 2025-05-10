#!/bin/bash
# Script for Hyperion v4 that performs Wordpress scans  https://github.com/wpscanteam/wpscan
# INSTALL FIRST whatweb https://github.com/urbanadventurer/WhatWeb/wiki/Installation
# Tutorial https://tools.kali.org/web-applications/whatweb
# target
N=$1

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# WAF
wafw00f https://$1 > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt
# whatweb
whatweb -v -a 4 -l --logxml=what.xml https://$1
xsltproc what.xml > whatcms1.html

# Wordpress
docker pull wpscanteam/wpscan
docker run -it --rm wpscanteam/wpscan --url https://$1 > p.txt
cat p.txt | grep users > wp.txt
sed -i '1i WPScan Results\n----------------------' wp.txt
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker run -it --rm wpscanteam/wpscan --url https://$1 --enumerate u > w1.txt
cat w1.txt | grep users > wp1.txt
sed -i '1i WPScan Users Results Users\n------------------------------' wp1.txt
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker run -it --rm wpscanteam/wpscan --url https://$1 --enumerate p > w2.txt
cat w2.txt | grep plugins > wp2.txt
sed -i '1i WPScan Plugins Results Plugins\n-----------------------------' wp2.txt
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker run -it --rm wpscanteam/wpscan --url https://$1 --enumerate t > w3.txt
cat w3.txt | grep theme > wp3.txt
sed -i '1i WPScan Themes Results Themes\n----------------------------' wp3.txt
cat waf.txt wp.txt wp1.txt wp2.txt wp3.txt > outputcms1.txt
# zip

zip wp.zip outputcms1.txt whatcms1.html

# clean up
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
