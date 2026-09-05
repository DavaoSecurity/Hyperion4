#!/usr/bin/env bash
# Convert all files in a directory (recursively) from CRLF to LF

# Directory to process – change as needed
TARGET_DIR="${1:-.}"

# Find regular files (skip binary files) and run dos2unix on each
find "$TARGET_DIR" -type f ! -name "*.bin" -print0 |
while IFS= read -r -d '' file; do
    # Skip files that already have LF endings
    if grep -q $'\r' "$file"; then
        echo "Converting: $file"
        # In‑place conversion using tr
        tr -d '\r' < "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    fi
done

echo "Conversion complete."

# If the dos2unix utility is installed, the script can be simplified:
# #!/usr/bin/env bash
# TARGET_DIR="${1:-.}"
# find "$TARGET_DIR" -type f -exec dos2unix -q {} +
