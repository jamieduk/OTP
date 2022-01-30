#!/bin/bash
# (c) J~Net 2022
# 
#
# ./menu.sh
#
#path="/home/$USER/Documents/Scripts/LanBackup_Full"
#
#
echo -en "\e[92mType Or Paste Plaintext"
echo ""
read input
echo "You said $input"
echo $input > text.txt
echo "Ready To Encrypt"
echo ""
echo "Ready To Go Back To Menu?"
read Y
bash menu.sh
