#!/bin/bash
# Script  performs database server tests using SQL cripts and nmap
r=$1
t=$2

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX unmap.xml
xsltproc unmap.xml -o unmapdb.html
# nmap
sudo nmap -p - --script ms-sql-info --script mysql-databases --script ms-sql-query --script-args mssql.username=sa,mssql.password=sa,ms-sql-query.query="SELECT * FROM master..syslogins" --script ms-sql-empty-password --script ms-sql-hasdbaccess --script ms-sql-tables --script-args mssql.usernam=sa --script ms-sql-xp-cmdshell --script-args mssql.username=sa --script ms-sql-xp-cmdshell --script-args=ms-sql-xp-cmdshell.cmd='net users',mssql.username=sa --script ms-sql-dump-hashes --script-args mssql.username=sa $1 -oX us.xml
xsltproc us.xml -o nmapdb.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} database.zip unmapdb.html nmapdb.html

# Email Report and Password
echo " Database SQL Report database.zip" | mail -s "Database (no SQLMAP) Report for "$1" " -A database.zip $2
echo " Your password for "$1" database.zip is "${pass}" " | mail -s "Your database.zip Info" $2
