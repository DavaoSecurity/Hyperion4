#!/bin/bash
# Script for Hyperion v4 for Ashok scanner
# target
d=$1

docker pull powerexploit/ashok-v1.2
docker container run -it powerexploit/ashok-v1.2  --dns $1 > ashok.txt

sed -i -e '1iAshok files\' ashok.txt
sed -i -e '2i***************************\' ashok.txt
cd ..

# zip
zip askok.txt
rm ashok.txt
