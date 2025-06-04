#!/bin/bash

# Check if a name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <name>"
    exit 1
fi

NAME="$1"
NAME_CLEANED=$(echo "$NAME" | tr ' ' '+' | tr '[:upper:]' '[:lower:]')  # Clean the name for URL usage

echo "Gathering OSINT for: $NAME"

# Step 1: Search for possible domains using Google
echo "Searching for possible domains..."
curl -s "https://www.google.com/search?q=$NAME_CLEANED+domain" | \
grep -oP '(?<=href=")/url\?q=[^&]+' | \
sed 's/^\/url?q=//;s/&.*$//;s/%20/ /g' | \
grep -E '\.(com|net|org|info|biz|co|io|me)' | uniq

# Step 2: Search for email addresses using theHarvester
echo "Searching for email addresses..."
theHarvester -d "$NAME_CLEANED" -b google -l 50 | grep -i "$NAME"

# Step 3: Search for social media profiles
echo "Searching for social media profiles..."
echo "Searching Twitter..."
curl -s "https://twitter.com/search?q=$NAME_CLEANED" | grep -oP '(?<=href=")/[A-Za-z0-9_]+'

echo "Searching LinkedIn..."
curl -s "https://www.linkedin.com/search/results/people/?keywords=$NAME_CLEANED" | grep -oP '(?<=href=")/in/[A-Za-z0-9_-]+'

echo "OSINT gathering completed........."
