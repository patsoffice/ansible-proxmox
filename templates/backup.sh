#!/bin/bash

#This is a rdiff-backup utility backup script

#Backup command
rdiff-backup --api-version 201 --new backup --print-statistics {{ backup_src }} {{ backup_dest }} >>/var/log/backup.log

#Checking rdiff-backup command success/error
status=$?
if [ $status != 0 ]; then
        #append error message in /var/log/backup.log file
        echo "rdiff-backup exit Code: $status - Command Unsuccessful" | tee -a /var/log/backup.log;
        exit 1;
fi

#Remove incremental backup files older than one month
rdiff-backup --api-version 201 --new --force remove increments --older-than 1M {{ backup_dest }} >>/var/log/backup.log
