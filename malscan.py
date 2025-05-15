# Hyperion v4 Malware Checker in Python by Nathan W Jones nat@davaosecurity.com
# Hash Calculation: The get_file_hash function computes the SHA256 hash of a file.
# Malware Check: The check_malware function sends a request to the Malware Bazaar API to check if the hash is known to be malicious.
# File Scanning: The scan_file function scans a single file and prints whether it is clean or detected as malware.
# Directory Scanning: The scan_directory function walks through the specified directory and uses a thread pool to scan files concurrently.
# API Key: Replace "your_api_key_here" with your actual API key from Malware Bazaar.
# Error Handling: The code includes basic error handling, but you may want to enhance it for production use.
# Performance: The use of threading can significantly speed up the scanning process, especially for large directories with many files.
# Legal and Ethical Considerations: Ensure you have permission to scan the files and that you comply with all relevant laws and regulations.
# https://bazaar.abuse.ch/api/  to get API
# pip install requests and best run in Kali Linux
# Replace "your_api_key_here" with your actual API key from Malware Bazaar.
# Save the code to a file, e.g., malware_detector.py. CHMOD FILE!!
# Run the script using Python: python malware_detector.py.

import os
import requests
import hashlib
import concurrent.futures

MALWARE_BAZAAR_API_URL = "https://mb-api.abuse.ch/api/v1/"
API_KEY = "your_api_key_here"  # Replace with your actual API key

def get_file_hash(file_path):
    """Calculate the SHA256 hash of a file."""
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        # Read and update hash string value in blocks of 4K
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def check_malware(hash_value):
    """Check if the hash is in the Malware Bazaar database."""
    payload = {
        "api_key": API_KEY,
        "hash": hash_value
    }
    response = requests.post(MALWARE_BAZAAR_API_URL + "report", json=payload)
    if response.status_code == 200:
        return response.json()
    else:
        return None

def scan_file(file_path):
    """Scan a single file for malware."""
    try:
        file_hash = get_file_hash(file_path)
        result = check_malware(file_hash)
        if result and result.get('data'):
            print(f"[MALWARE DETECTED] {file_path} - {result['data']}")
        else:
            print(f"[CLEAN] {file_path}")
    except Exception as e:
        print(f"[ERROR] {file_path}: {e}")

def scan_directory(directory):
    """Scan all files in a directory."""
    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = []
        for root, _, files in os.walk(directory):
            for file in files:
                file_path = os.path.join(root, file)
                futures.append(executor.submit(scan_file, file_path))
        # Wait for all futures to complete
        concurrent.futures.wait(futures)

if __name__ == "__main__":
    directory_to_scan = "/path/to/your/directory"  # Change this to your target directory
    scan_directory(directory_to_scan)
