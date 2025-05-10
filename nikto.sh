#!/bin/bash
# Hyperion v4 nikto https://github.com/sullo/nikto
# target
a=$1

# git clone https://github.com/sullo/nikto.git
cd nikto
nikto.pl -update
nikto -h https://$1 -o nikto.htm
mv nikto.htm /root

# zip
zip nikto.zip nikto.htm

# clean up
rm nikto.htm nikto.zip
cd ..
