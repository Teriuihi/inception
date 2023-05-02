#!/bin/sh

filename="/etc/hosts"
host_data='127.0.0.1 sappunn.42.fr'

if grep -q "$host_data" "$filename"; then
  exit 0
else
  echo "$host_data" >> "$filename"
fi
