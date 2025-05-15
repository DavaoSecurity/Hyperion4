#!/bin/bash 
# Hyperion v4 OSINT tools in Kali by Nathan W Jones nat@davaosecurity.com
# install whois, dig, nmap, theharvester, sublist3r, metasploit, amass
# change the DOMAIN variable to the target domain
# chmod +x osintfull.sh        sudo ./osintfull.sh

# Output HTML file
OUTPUT_FILE="osint_report.html"

# Start HTML file
echo "<html>" > $OUTPUT_FILE
echo "<head><title>OSINT Report</title>" >> $OUTPUT_FILE
echo "<style>" >> $OUTPUT_FILE
echo "body { font-family: Arial, sans-serif; }" >> $OUTPUT_FILE
echo "h1 { color: #333; }" >> $OUTPUT_FILE
echo "h2 { color: #555; }" >> $OUTPUT_FILE
echo "pre { background-color: #f4f4f4; padding: 10px; border-radius: 5px; }" >> $OUTPUT_FILE
echo "</style>" >> $OUTPUT_FILE
echo "</head>" >> $OUTPUT_FILE
echo "<body>" >> $OUTPUT_FILE
echo "<h1>OSINT Report</h1>" >> $OUTPUT_FILE

# Function to run a command and append output to HTML
run_command() {
    echo "<h2>$1</h2>" >> $OUTPUT_FILE
    echo "<pre>" >> $OUTPUT_FILE
    eval "$2" >> $OUTPUT_FILE 2>&1
    echo "</pre>" >> $OUTPUT_FILE
}

# Example target domain
DOMAIN="example.com"

# WHOIS Lookup
run_command "WHOIS Lookup" "whois $DOMAIN"

# DNS Lookup
run_command "DNS Lookup" "dig $DOMAIN ANY"

# Nmap Scan
run_command "Nmap Scan" "nmap -sP $DOMAIN"

# TheHarvester
run_command "TheHarvester" "theharvester -d $DOMAIN -b all"

# Sublist3r
run_command "Sublist3r" "sublist3r -d $DOMAIN -o subdomains.txt && cat subdomains.txt"

# Amass
run_command "Amass Enumeration" "amass enum -d $DOMAIN -o amass_output.txt && cat amass_output.txt"

# Metasploit's DNS Enumeration
run_command "Metasploit DNS Enumeration" "msfconsole -q -x 'use auxiliary/gather/dns_enum; set DOMAIN $DOMAIN; run; exit'"

# End HTML file
echo "</body>" >> $OUTPUT_FILE
echo "</html>" >> $OUTPUT_FILE

echo "OSINT report generated: $OUTPUT_FILE"

rm subdomain.txt amass_output.txt
