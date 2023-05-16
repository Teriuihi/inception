#!/bin/bash

file_path="/etc/hosts"
host_string="127.0.0.1 sappunn.42.fr"

if ! grep -q "$host_string" "$file_path"; then
	echo $host_string >> $file_path
fi
