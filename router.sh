#!/bin/bash
#Author: Nicholas Palmer

#Colors for easy use. Tends to grab your attention when something goes wrong
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

if [ $# -eq 0 ]
then
	#Get the IP address of each machine
	read -p "Machine A/Router IP Address: " routerip
	read -p "Machine B/Webserver IP Address: " webserverip
	read -p "Machine C/FTP Server IP Address: " ftpserverip
	read -p "Machine D/DNS Server IP Address: " dnsserverip
	read -p "Machine F/Webserver IP Address: " backupwebip
	read -p "Machine E/File Server IP Address: " fileserverip

	#Store these into an array for easy looping
	machines=("$routerip" "$webserverip" "$ftpserverip" "$dnsserverip" "$backupwebip" "$fileserverip")
	printf "========================================================\n\n"

	#Ask the user if they would like to save this config
	read -p "Would you like to save this configuration? (Y/n) " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		#Save The configuration
		read -p "Enter path of file to save: "
		printf "%s\n" "${machines[@]}" > $REPLY
	fi

else
	echo "Reading configuration from file $1"
	machines=()
	while IFS= read -r line; do
		machines+=("$line")
	done < $1
fi
printf "========================================================\n\n"

#Ping each machine to see host availability
check_availability () {
	for address in ${machines[@]};
	do
		#Ping machine A
		printf "Checking host availability for host $address\n"
		ping -c1 $address > /dev/null
		if [ $? -eq 0 ]
		then
			#The ping was successful
			printf "${grn}Host $address is available!${end}\n"
		else
			printf "${red}The host at $address did not respond to ping.${end}\n"
			printf "Check that the host is online and can recieve ICMP traffic\n"
		fi
		printf "========================================================\n\n"
	done
}

#Check the configuration of machine A
check_machine_a () {
	printf "Checking the configuration of Machine A"
}

#Check the availability of each host machine
check_availability

echo "Select an operation: "
echo "  1) Check Machine A/Router"
echo "  2) Check Machine B/Web Server"
echo "  3) Check Machine C/FTP Server"
echo "  4) Check Machine D/DNS Server" 
echo "  5) Check Machine F/Web Server" 
echo "  6) Check Machine E/File Server" 

read n
case $n in
	1) check_machine_a;;
	2) echo "You chose Option 2";;
	3) echo "You chose Option 3";;
	4) echo "You chose Option 4";;
	*) echo "invalid option";;
esac










