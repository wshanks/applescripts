#! /bin/bash

#Get all disk names
DISKL=$(diskutil list | awk '/^\/dev/ {print $1}')

OPTICALNAMELIST=''
IFS=''
while read -r TEMPDISK; do
	#Check each disk's info for the word "optical" -- only found in optical disks
	OPTICALSTR=$(diskutil info $TEMPDISK | sed 's/^[ \t]*//' | grep "Optical")
	if [ -n "$OPTICALSTR" ]; then
		#Get list of partitions of disk identified as optical drive
		
		DISKNAME=$(diskutil info $TEMPDISK | grep 'Volume Name' | sed s'/Volume Name://' | sed -e 's/^[ \t]*//')
		if [ -n "$OPTICALNAMELIST" ]; then
			OPTICALNAMELIST=$(echo -e "$OPTICALNAMELIST\n$DISKNAME")
		else
			OPTICALNAMELIST=$DISKNAME
		fi
	fi
done <<< "$DISKL"

echo $OPTICALNAMELIST