#!/bin/bash

path=$(/usr/bin/dirname "$0")

if [ ! -f "$path"/.env ];
then
	echo "No .env file found."
	exit 1
fi

export $(/bin/cat "$path"/.env | /usr/bin/xargs)

if [ -z "$MAC_ADDRESS" ];
then
	echo "No MAC ADDRESS to scan for"
	exit 1
fi

PATTERN=${MAC_ADDRESS//,/\\|}

while [ 1 ]; do
	echo "Scanning for $PATTERN availability."
        OUT=`nmap -p 5353 -sV -O $SUBNET | /bin/grep $PATTERN`
        if [ -z "$OUT" ]
                then
			echo "Not found. Sleeping\n"
			`/bin/sleep 5`
       		else
			echo "Found\n"
			`/bin/sleep 3`
			`php $path/youtube-castnow.php & > /dev/null &`
		exit 1
 fi
done
