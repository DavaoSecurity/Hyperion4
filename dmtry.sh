#!/bin/bash
# Hyperion v4 dmitry
# target
h=$1
#
dmitry $1 -o dim

# zip
zip dmitry.zip dim.txt

# clean up
rm dim.txt
