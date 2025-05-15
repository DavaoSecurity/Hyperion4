# pip install requests
# Hyperion v4 NIST Vulnerability by Nathan W Jones nat@davaosecurity.com
# could do the same script for CVE
# python3 nist.py

import requests
import json
from datetime import datetime

def fetch_vulnerabilities(target):
    # NVD API endpoint
    url = f"https://services.nvd.nist.gov/rest/json/cves/1.0?keyword={target}&resultsPerPage=20"

    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for bad responses
        return response.json()
    except requests.RequestException as e:
        print(f"Error fetching data from NVD: {e}")
        return None

def generate_html_report(vulnerabilities, target, output_file):
    with open(output_file, 'w') as f:
        f.write("<html><head><title>Vulnerability Report</title></head><body>")
        f.write(f"<h1>Vulnerability Report for {target}</h1>")

        if vulnerabilities and 'result' in vulnerabilities and 'CVE_Items' in vulnerabilities['result']:
            cve_items = vulnerabilities['result']['CVE_Items']
            if cve_items:
                f.write("<table border='1'><tr><th>CVE ID</th><th>Description</th><th>Published Date</th></tr>")
                for item in cve_items:
                    cve_id = item['cve']['CVE_data_meta']['ID']
                    description = item['cve']['description']['description_data'][0]['value']
                    published_date = item['publishedDate']
                    f.write(f"<tr><td>{cve_id}</td><td>{description}</td><td>{published_date}</td></tr>")
                f.write("</table>")
            else:
                f.write("<p>No vulnerabilities found.</p>")
        else:
            f.write("<p>Error retrieving vulnerabilities.</p>")

        f.write("</body></html>")

def main():
    target = input("Enter the target (software name or version): ")
    output_file = input("Enter the output HTML file name (e.g., report.html): ")

    print("Fetching vulnerabilities...")
    vulnerabilities = fetch_vulnerabilities(target)

    print("Generating report...")
    generate_html_report(vulnerabilities, target, output_file)

    print(f"Report generated: {output_file}")

if __name__ == "__main__":
    main()
