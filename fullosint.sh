#!/bin/bash
# sudo apt update
# sudo apt install whois dnsutils sublist3r nmap theharvester
# Hyperion v4 comprehensive OSINT using Kali Linux

# Check if the target domain is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target_domain>"
    exit 1
fi

TARGET=$1
OUTPUT_DIR="osint_results"
mkdir -p $OUTPUT_DIR

# Function to perform WHOIS lookup
whois_lookup() {
    echo "Performing WHOIS lookup..."
    whois $TARGET > "$OUTPUT_DIR/whois_$TARGET.txt"
}

# Function to perform DNS enumeration
dns_enum() {
    echo "Performing DNS enumeration..."
    dig $TARGET ANY > "$OUTPUT_DIR/dns_$TARGET.txt"
    nslookup $TARGET >> "$OUTPUT_DIR/dns_$TARGET.txt"
}

# Function to gather subdomains
subdomain_enum() {
    echo "Gathering subdomains..."
    sublist3r -d $TARGET -o "$OUTPUT_DIR/subdomains_$TARGET.txt"
}

# Function to check for open ports
port_scan() {
    echo "Performing port scan..."
    nmap -sS -p- $TARGET -oN "$OUTPUT_DIR/nmap_$TARGET.txt"
}

# Function to gather social media information
social_media_search() {
    echo "Searching for social media presence..."
    theharvester -d $TARGET -b all -l 500 -f "$OUTPUT_DIR/social_media_$TARGET.html"
}

# Function to gather general information
general_info() {
    echo "Gathering general information..."
    curl -s "https://api.hackertarget.com/hostsearch/?q=$TARGET" > "$OUTPUT_DIR/general_info_$TARGET.txt"
}

# Execute functions
whois_lookup
dns_enum
subdomain_enum
port_scan
social_media_search
general_info

echo "OSINT scan completed. Results are saved in the $OUTPUT_DIR directory."
