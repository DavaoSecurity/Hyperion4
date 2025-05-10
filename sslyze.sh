# sslyze https://github.com/nabla-c0d3/sslyze
#!/bin/bash
h=$1
v=$2
docker run --rm -it nablac0d3/sslyze:5.0.0 $1 > sslyze.txt
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} sslyze.zip sslyze.txt
echo " Your password for "$1" sslyze.zip is "${pass}" " | mail -s "Your sslyze.zip Info" $2
# Email Report
echo " sslyze Scan " | mail -s "sslyze Report for "$1" " -A sslyze.zip $2

