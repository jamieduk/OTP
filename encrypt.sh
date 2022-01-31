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
echo "Your Text $input To Be Encrypted"
echo ""
# Encrypt the plaintext with the otp
./otp.sh -e "$input" otp.txt > cipher.txt
echo ""
echo "All Done!"
echo "Your Cipher Text Is"
cat cipher.txt
echo ""
echo "Key Is Stored As otp.txt, Ready To Go Back To Menu?"
read Y
bash menu.sh
