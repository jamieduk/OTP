#!/bin/bash
# (c) J~Net 2022
# 
#
# ./menu.sh
#
#path="/home/$USER/Documents/Scripts/LanBackup_Full"
#
# To Manually Do It

# Generate a One Time Pad based on the length of the plaintext
./otp.sh -o test.txt otp.txt > otp.txt

# Encrypt the plaintext with the otp
./otp.sh -e test.txt otp.txt > cipher.txt

echo ""
cat cipher.txt
echo ""
echo "Thats Your Cipher Text Key Is Stored As otp.txt, Ready To Go Back To Menu?"
read Y
bash menu.sh
