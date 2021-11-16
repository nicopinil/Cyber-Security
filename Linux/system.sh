#!/bin/bash

free -h | awk -F" " '{print $4}' | tail -2 >> ~/backups/freemem/free_mem.txt

df -h | awk '{print $3}' >> ~/backups/diskuse/disk_usage.txt

lsof | wc -l >> ~/backups/openlist/open_list.txt

df | awk -F" " '{print $3, $4, $5}' >> ~/backups/freedisk/free_disk.txt

