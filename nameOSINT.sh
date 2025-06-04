#!/bin/bash
# ./nameOSINT "John Doe"

# Check if a name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <name>"
    exit 1
fi

NAME="$1"
NAME_CLEANED=$(echo "$NAME" | tr ' ' '+' | tr '[:upper:]' '[:lower:]')  # Clean the name for URL usage
OUTPUT_FILE="osint_results_${NAME_CLEANED}.txt"

# Create or clear the output file
echo "OSINT Results for: $NAME" > "$OUTPUT_FILE"
echo "=============================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Step 1: Search for possible domains using Google
echo "Searching for possible domains..." | tee -a "$OUTPUT_FILE"
curl -s "https://www.google.com/search?q=$NAME_CLEANED+domain" | \
grep -oP '(?<=href=")/url\?q=[^&]+' | \
sed 's/^\/url?q=//;s/&.*$//;s/%20/ /g' | \
grep -E '\.(com|net|org|info|biz|co|io|me)' | uniq >> "$OUTPUT_FILE"

# Step 2: Search for email addresses using theHarvester
echo "" >> "$OUTPUT_FILE"
echo "Searching for email addresses..." | tee -a "$OUTPUT_FILE"
theHarvester -d "$NAME_CLEANED" -b google -l 50 | grep -i "$NAME" >> "$OUTPUT_FILE"

# Step 3: Search for social media profiles
echo "" >> "$OUTPUT_FILE"
echo "Searching for social media profiles..." | tee -a "$OUTPUT_FILE"
echo "Searching Twitter..." | tee -a "$OUTPUT_FILE"
curl -s "https://twitter.com/search?q=$NAME_CLEANED" | grep -oP '(?<=href=")/[A-Za-z0-9_]+' >> "$OUTPUT_FILE"

echo "Searching LinkedIn..." | tee -a "$OUTPUT_FILE"
curl -s "https://www.linkedin.com/search/results/people/?keywords=$NAME_CLEANED" | grep -oP '(?<=href=")/in/[A-Za-z0-9_-]+' >> "$OUTPUT_FILE"

echo "OSINT gathering completed. Results saved to $OUTPUT_FILE."
