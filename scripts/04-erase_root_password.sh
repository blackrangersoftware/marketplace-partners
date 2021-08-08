#!/bin/bash

if [ "$EUID" -ne 0 ]
then echo "[Error] - This script must be run with sudo or as the root user."
exit 1
fi

echo "Would you like to erase the root password? If you answer YES you will no longer be able to log in as root."
read answer
if [ "$answer" = "YES" ]; then
echo "Erasing root password"
sed -i'' 's/^(root:)[^:](:.)$/\1*\2/' /etc/shadow
if grep -q '^root:*:' /etc/shadow
echo "It appears root's password has been disabled successfully."
else
echo "Warning: it appears root's password has NOT been disabled."
fi
else
echo "NOT erasing root password."
fi