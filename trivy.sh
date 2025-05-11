#!/bin/bash
# Hyperion 4 Ubuntu Snap Trivy

trivy fs --scanners vuln / > trivy.txt
sed -i '1i TRIVY Output\--------------------' trivy.txt

# zip
zip trivy.zip trivy.txt
# clean up
rm trivy.txt trivy.zip
