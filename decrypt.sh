#!/bin/bash
# (c) J~Net 2022
# 
#
# ./menu.sh
#
#path="/home/$USER/Documents/Scripts/LanBackup_Full"
#
#
#To Manually Do It
# Decrypt the cipher text using the otp
./otp.sh -d cipher.txt otp.txt > dec.txt
echo ""
cat dec.txt
echo ""
echo "End Of Decryption!"
echo "Ready To Go Back To Menu?"
read Y
bash menu.sh
