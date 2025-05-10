#!/bin/bash
# Hyperion v4 fast google dork scanner https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan
# target
i=$1

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
