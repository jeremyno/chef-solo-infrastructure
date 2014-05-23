#!/bin/bash

# Usage: ./deploy.sh [host]
if [ $# -ne 2 ] ; then 
  echo "Usage: $0 <host> <user>"
  exit 1
fi

host="$1"
user="$2"

dir=`dirname $0`
cd "$dir"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
#ssh-keygen -R "${host#*@}" 2> /dev/null


hostpath="$user@$host"
echo "Connecting to $hostpath"

tar cj . | ssh -o 'StrictHostKeyChecking no' "${hostpath}" "
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
cp "config/$host.json" solo.json && 
sudo bash install.sh"
