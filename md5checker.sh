#!/bin/bash

[ "$#" -ne 2 ] && echo "Illegal parameters! USAGE: $0 <FILE> <HASH>" && exit 2


if [ -z "$1" -o  -z "$2" ]
then
	echo "File argument cannot be < 2"
	echo "Exiting..."
	exit 0
fi

md5sum $1 
if [ $? -eq 0 ]; then
	file_hash=$(md5sum $1 | cut -d ' ' -f 1   )	
else 
	exit 0
fi 

arg_hash=$2
size_arg_hash=$(echo ${#arg_hash})
size_md5_bytes=32

if [ $size_arg_hash != $size_md5_bytes ] # search for better validations
then
	echo
	echo "The MD5 hash you've entered is invalid, exiting..."
	exit 0
fi

echo
echo "Verifying..."
echo

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
	
