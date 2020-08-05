#!/bin/bash

# messages to append in the beginning of the output messages
success_msg="[SUCCESS]"
fail_msg="[FAIL]"

# checks if the number of arguments is valid
[ "$#" -ne 2 ] && echo "$fail_msg; Illegal number of arguments! USAGE: $0 <FILE> <HASH>" && exit 2

file_or_directory="$1"

# if the file exists and if it's not a directory
if [ -f "${file_or_directory}" ]; then
	echo "$success_msg file found!" 

elif [ -d "${file_or_directory}" ]; then
	echo "$fail_msg ${file_or_directory} is a directory. Exiting..."
	exit 2
else
	echo "$fail_msg file not found! Exiting..." 
	exit 2
fi

# if the md5sum script ran properly
if [ $? -eq 0 ]; then
	file_hash=$(md5sum $file_or_directory | cut -d ' ' -f 1   )	
else 
	exit 2
fi 

arg_hash=$2
size_arg_hash=$(echo ${#arg_hash})
size_md5_bytes=32

if [ $size_arg_hash != $size_md5_bytes ] # search for better validations
then
	echo
	echo "$fail_msg The MD5 hash you've entered is invalid, exiting..."
	exit 2
fi

echo "**************"
echo "Verifying..."
echo "**************"

if [ $file_hash == $arg_hash ] 
then
	echo
	echo "$success_msg Yup! $file_or_directory = $2"
	echo "... done. "
    echo
else 
	echo "$fail_msg Hashes don't match. Exiting... "
	echo
	echo "$file_hash is NOT equals to $arg_hash. Exiting..."
	echo
	echo "Bye!"
fi
	
