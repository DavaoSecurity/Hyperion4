#!/bin/bash
 # Hyperion v4 OpenVAS Script
# Prerequisites
# OpenVAS should be installed and configured on your Kali Linux system.
# You should have the necessary permissions to run scans.
# The OpenVAS services should be running.
# Replace `admin` and `admin` in the `omp` commands with your actual OpenVAS username and password if they are different.
# Ensure that the `gvm` and `omp` commands are available in your PATH. You may need to install the `gvm-tools` package if you haven't done so.
# The script assumes that OpenVAS is configured to allow command-line access via `omp`. You may need to adjust settings in OpenVAS for this to work.
# Always ensure you have permission to scan the target to avoid legal issues.

# Instructions
# Save the script to a file, for example, `run_openvas_scan.sh`.
# Make the script executable: chmod +x run_openvas_scan.sh
# Run the script with the target IP or hostname as an argument: ./run_openvas_scan.sh <target-ip-or-hostname>

# Check if the user provided a target
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target-ip-or-hostname>"
    exit 1
fi

TARGET=$1

# Start OpenVAS services (if not already running)
echo "Starting OpenVAS services..."
sudo gvm-start

# Wait for OpenVAS to start
sleep 10

# Create a new target in OpenVAS
echo "Creating target for $TARGET..."
TARGET_ID=$(omp -u admin -w admin --create-target "$TARGET" | grep -oP '(?<=<id>).*?(?=</id>)')

if [ -z "$TARGET_ID" ]; then
    echo "Failed to create target."
    exit 1
fi

# Create a new task for the target
echo "Creating task for target ID $TARGET_ID..."
TASK_ID=$(omp -u admin -w admin --create-task "Scan of $TARGET" "$TARGET_ID" | grep -oP '(?<=<id>).*?(?=</id>)')

if [ -z "$TASK_ID" ]; then
    echo "Failed to create task."
    exit 1
fi

# Start the scan
echo "Starting scan for task ID $TASK_ID..."
omp -u admin -w admin --start-task "$TASK_ID"

echo "Scan started for $TARGET. You can check the status in the OpenVAS web interface."
