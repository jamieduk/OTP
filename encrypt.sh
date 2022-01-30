#!/bin/bash
# (c) J~Net 2022
# 
#
# ./menu.sh
#
#path="/home/$USER/Documents/Scripts/LanBackup_Full"
#
# To Manually Do It
input=`cat text.txt`
# Encrypt the plaintext with the otp
./otp.sh -e "$input" otp.txt > cipher.txt

echo ""
cat cipher.txt
echo ""
echo "Thats Your Cipher Text, Key Is Stored As otp.txt, Ready To Go Back To Menu?"
read Y
bash menu.sh
