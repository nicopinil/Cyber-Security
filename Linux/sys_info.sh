#!/bin/bash

mkdir ~/Research

echo "bash script"
date >> ~/research/sys_info.txt
echo " " >> ~/research/sys_info.txt
echo "Machine Type Info:" >> ~/research/sys_info.txt
echo $MACHTYPE >> ~/research/sys_info.txt
echo -e "Uname info: $(uname -e) \n" >> ~/research/sys_info.txt
echo -e "IP info: $(ip addr | grep inet | tail -1) \n" >> ~/research/sys_info.txt
echo "Hostname: $(hostsname -s)" >> ~/research/sys_info.txt
echo -e /n"Files that are executable" >> ~/research/sys_info.txt
sudo find / -type f -perm 777 >> ~/research/sys_info.txt
echo -e /n"Top 10 Proceses" >> ~/research/sys_info.txt
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt

