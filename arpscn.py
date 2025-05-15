# Hyperion v4 ARP Network Scanner by Nathan W Jones nat@davaosecurity.com
# sudo apt-get install arp-scan      chmod +x network_scanner.py      python3 arpscan.py
# output is netscanresults.html

import subprocess
import sys

def scan_network(target_ip):
    try:
        # Run arp-scan command
        result = subprocess.run(['sudo', 'arp-scan', '-l', target_ip], capture_output=True, text=True)
        return result.stdout
    except Exception as e:
        print(f"Error scanning network: {e}")
        return None

def save_to_html(data, output_file):
    with open(output_file, 'w') as f:
        f.write("<html><body><h1>Network Scan Results</h1><pre>")
        f.write(data)
        f.write("</pre></body></html>")

def main():
    target_ip = input("Enter the target IP address or subnet (e.g., 192.168.1.0/24): ")
    output_file = "netscanresults.html"

    print(f"Scanning network: {target_ip}...")
    scan_results = scan_network(target_ip)

    if scan_results:
        save_to_html(scan_results, output_file)
        print(f"Scan results saved to {output_file}")

if __name__ == "__main__":
    main()
