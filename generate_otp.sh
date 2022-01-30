#!/bin/bash
# Generate a One Time Pad based on the length of the plaintext
./otp.sh -o test.txt otp.txt > otp.txt
echo "Stored in otp.txt"
echo ""
echo "Ready To Go Back?"
read Y
bash menu.sh
