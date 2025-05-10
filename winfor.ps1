# get computer info
Get-CimInstance -Class CIM_ComputerSystem -ComputerName localhost -ErrorAction Stop | Select-Object *

<<<<<<< HEAD
# get remote system info
=======
# get remote system info 
>>>>>>> 292a44fde6b63800f7a09c511f93c6647a7589bb
Get-CimInstance -Class CIM_ComputerSystem -ComputerName (Get-Content -Path C:\Temp\Servers.txt) -ErrorAction Stop | Select-Object * | Out-GridView
