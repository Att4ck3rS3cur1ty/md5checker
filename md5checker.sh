#!/bin/bash

if [ -z "$1" -o  -z "$2" ]
then
	echo "File argument cannot be < 2"
	echo "Exiting..."
	exit 0
fi

file_hash=$(md5sum $1 | cut -d ' ' -f 1   )
arg_hash=$2
size_arg_hash=$(echo ${#arg_hash})
size_md5_bytes=32
echo
echo "Verifying..."
echo

if [ $size_arg_hash != $size_md5_bytes ] # search for better validations
then
	echo "Invalid MD5 hash: exit 0"
	exit 0
fi

if [ $file_hash == $arg_hash ] 
then
	echo
	echo "Yup! $1 = $2"
	echo "... done. "
      	echo
else 
	echo "Fail! Hashes don't match. "
	echo
	echo "$file_hash is NOT equals to $arg_hash"
	echo
	echo "Bye!"
fi
	
