#!/bin/bash 

HOST=s1.eleximg.com #This is the FTP servers host or IP address. 
USER=ram             #This is the FTP user that has access to the server. 
PASS=XUk29m5fSKkYToD          #This is the password for the FTP user. 

# Call 1. Uses the ftp command with the -inv switches.  -i turns off interactive prompting. -n Restrains FTP from attempting the auto-login feature. -v enables verbose and progress.  

ftp -inv $HOST <<EOF 
user $USER $PASS 

ls

cd download
ls

bye 
EOF  

echo "================="
