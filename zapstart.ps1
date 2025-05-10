# Docker Install and Auto Start
# Go to https://docs.docker.com/desktop/install/windows-install/ and click on Docker Desktop for Windows. Go to Downloads and double click to install.
# When prompted, ensure the Use WSL 2 instead of Hyper-V option on the Configuration page is selected.
# Follow the instructions on the installation wizard to authorize the installer and proceed with the install.
# Docker Desktop does not start automatically after installation. To start Docker Desktop, Search for Docker, and select Docker Desktop in the search results.
# Open Powershell as Administrator

# Docker Pull, Update Stable Release, and Security addons
docker pull ghcr.io/zaproxy/zaproxy:stable
docker pull softwaresecurityproject/zap-stable

# user input target
$Target = Read-Host -Prompt 'Input your Target e.g. https://example.com'

# user input Report name
$Report = Read-Host -Prompt 'Input the name for your Report e.g. MyReport.html. HTML extension only.'

# user input email Report
$Email = Read-Host -Prompt 'Input the email you want Report to be sent to e.g. person@email.com.'

# Windows Powershell. Runs a Baseline OWASPZAP.
# docker run -v "$(pwd):/zap/wrk/:rw" -t owasp/zap2docker-stable zap-baseline.py -t $Target -r $Report

# Email Report
$From = "your@gmail.com"
$To = "bob@some.com"
$Cc = " "
$Attachment = "C:\User\Documents\$Report"
$Subject = "OWASP-ZAP"
$Body = "<h2>Your OWASP-ZAP Results</h2><br><br>"
$Body += "Thank You."
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "465"
Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential (Get-Credential) -Attachments $Attachment

























# Docker purge and shutdown
