#!/bin/bash

# Reads a domain name, creates a folder, downloads the websites main html file, looks for links associated with
# the domain name, locates the subdomains and resolves them.

read -p "Domain name: " domain

echo "downloading $domain index page "

if [[ $domain == *www.* ]]; then
	domain="${domain:4}" #if user inputs 'www.' then get rid of it.
fi

echo "creating 'resolver' folder"
mkdir resolver
cd ./resolver

wget "www.$domain"

echo "stripping subdomains from index.html"
	for i in {1..3};do
		sleep 0.5
		echo -n "."
	done

	grep -o '[^/]*\.'$domain ./index.html | sort -u | uniq -u > subdomains.txt

echo "resolving subdomains"
	for i in {1..3};do
		sleep 0.5
		echo -n "."
	done

	for subdomain in $(cat subdomains.txt);do
		host $subdomain >> resolved_subdomains.txt
	done

sleep 1

cat resolved_subdomains.txt | grep "has address" | cut -d " " -f 4 | sort -u > ip.txt

rm ./resolved_subdomains.txt

printf "\ndone"

read -p "Show results? [Y/N]" show
    case $show in
        [Yy]* ) cat ip.txt;;
        [Nn]* ) echo "bye";;
        * ) echo "Please answer yes or no.";;
    esac

cd ..
