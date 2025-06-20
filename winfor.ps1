# Define the output file path
$outputFilePath = "C:\ForensicResults.txt"

# Get the current date and time
$currentTime = Get-Date

# Write the header to the output file
"Forensic Analysis Results - $currentTime" | Out-File -FilePath $outputFilePath

# Get the system information
"System Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_ComputerSystem | Select-Object -Property Name, Manufacturer, Model, SystemType, SystemFamily | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the operating system information
"Operating System Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property Caption, ServicePack, Version, BuildNumber, OSArchitecture | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the processor information
"Processor Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_Processor | Select-Object -Property Name, DeviceID, Manufacturer, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the memory information
"Memory Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_PhysicalMemory | Select-Object -Property Capacity, DeviceLocator, Manufacturer, PartNumber, SerialNumber | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the disk information
"Disk Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_DiskDrive | Select-Object -Property Model, Size, InterfaceType, Status | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the network adapter information
"Network Adapter Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Select-Object -Property Description, DHCPEnabled, DHCPServer, IPAddress, IPSubnet, DefaultIPGateway | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the user account information
"User Account Information:" | Out-File -FilePath $outputFilePath -Append
Get-WmiObject -Class Win32_UserAccount | Select-Object -Property Name, Domain, SID, Status | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the process information
"Process Information:" | Out-File -FilePath $outputFilePath -Append
Get-Process | Select-Object -Property ProcessName, ID, PriorityClass, Responding, Handles | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the service information
"Service Information:" | Out-File -FilePath $outputFilePath -Append
Get-Service | Select-Object -Property Name, DisplayName, Status, StartType | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the event log information
"Event Log Information:" | Out-File -FilePath $outputFilePath -Append
Get-WinEvent -LogName Application, Security, System | Select-Object -Property TimeCreated, Id, LevelDisplayName, Message | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the registry key information
"Registry Key Information:" | Out-File -FilePath $outputFilePath -Append
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run | Select-Object -Property Name, Property | Format-List | Out-File -FilePath $outputFilePath -Append

# Get the file system information
"File System Information:" | Out-File -FilePath $outputFilePath -Append
Get-ChildItem -Path C:\ -Recurse -Force -ErrorAction SilentlyContinue | Select-Object -Property FullName, LastWriteTime, Length | Format-List | Out-File -FilePath $outputFilePath -Append
