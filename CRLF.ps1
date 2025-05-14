# Set the directory path
$directoryPath = "C:\Users\Nathan\OneDrive\Documents\GitHub\Hyperion4"

# Get all text files in the directory
Get-ChildItem -Path $directoryPath -File -Recurse | Where-Object { $_.Extension -eq ".py" } | ForEach-Object {
    # Read the content of the file
    $content = Get-Content -Path $_.FullName -Raw

    # Replace CRLF with LF
    $content = $content -replace "`r`n", "`n"

    # Write the modified content back to the file
    Set-Content -Path $_.FullName -Value $content -NoNewline
}

Write-Host "Conversion from CRLF to LF completed for all text files in the directory."
