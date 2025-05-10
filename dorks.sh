#!/bin/bash
# fast google dork scanner https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan
i=$1
z=$2

cd Fast-Google-Dorks-Scan
docker build -t dorkydorks .
docker run -it --rm dorkydorks $1

cd outputs
zip fgds.zip *.*
mv fgds.zip /root
# rm *.*
cd ..
cd ..

# zip
zip dork.zip fgds.zip

# Email Report and Password
echo " Google Dorks dork.zip" | mail -s " Fast Google Dorks Scanner dork.zip "$1" " -A dork.zip $2

