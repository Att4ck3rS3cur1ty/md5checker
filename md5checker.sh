#!/bin/bash

[ "$#" -ne 2 ] && echo "Illegal parameters! USAGE: $0 <FILE> <HASH>" && exit 2

file_or_directory="$1"

# if file exists
if [ -f "${file_or_directory}"  ]; then
	echo "[SUCCESS] file found!" 

elif [ -d "${file_or_directory}" ]; then
	echo "${file_or_directory} is a directory. Exiting..."
	exit 2
else
	echo "[FAIL] file not found! Exiting..." 
	exit 2
fi

# if the md5sum script ran properly
if [ $? -eq 0 ]; then
	file_hash=$(md5sum $file_or_directory | cut -d ' ' -f 1   )	
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
	echo "Yup! $file_or_directory = $2"
	echo "... done. "
      	echo
else 
	echo "Fail! Hashes don't match. "
	echo
	echo "$file_hash is NOT equals to $arg_hash"
	echo
	echo "Bye!"
fi
	
