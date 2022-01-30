#!/bin/bash
#
# Simple script to encrypt text with a one-time pad

function gen_otp(){
    # Generate a One Time Pad based on the length of the string to be encrypted
    plaintext=$1
    plainlen=${#plaintext}

    # Generate the One Time Pad
    otp=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" |fold -w $plainlen | head -n 1)
    echo -n $otp
}

function otp_encrypt(){
    # XOR the plaintext string against the One Time Pad

    plaintext="$1"
    plainlen=${#plaintext}

    # Grab the OTP and base64 decode it
    otp=$2

    for (( i=0; i<${#plaintext}; i++ )); do
        char=$(printf '%d' "'${plaintext:$i:1}" )
        otpchar=$(printf '%d' "'${otp:$i:1}" )

        # XOR the two
        cipherchar=$(( $char ^ $otpchar ))

        # we convert to hex.
        # Converting back to an ASCII char is possible, but can give unpredictable results
        cipherstr=$cipherstr$(printf "%x " $cipherchar)

    done

    # Return the string, but base64 it for convenience in copy/pasting
    echo -n $cipherstr | base64
}

function otp_decrypt(){
    # Reverse the process applied in otp_encrypt to recover the plaintext
    ciphertext=$1
    ciphertext=$( echo -n "$ciphertext" | base64 -d )
    otp=$2
    pos=0
    for i in $ciphertext
    do

        cipherchar=$(printf '%d' "0x$i" )
        otpchar=$(printf '%d' "'${otp:$pos:1}" )

        cipherchar=$(( $cipherchar ^ $otpchar ))

        if [ "$cipherchar" == "10" ]
        then
            # We do this because BASH command substitution strips trailing newlines
            newchar=$(echo -e -n "\n"; echo -n "extrachar")
            newchar=${newchar%extrachar}
        else
            newchar="`printf "\x$(printf %x $cipherchar)"`"
        fi

        plainstr="${plainstr}${newchar}"
        pos=$(( $pos + 1 ))
    done

    echo "$plainstr"
}

# func main

mode=$1

# There are better ways to to usage checks, but this is quick
if [ ! "$mode" == "-e" ] && [ ! "$mode" == "-d" ] && [ ! "$mode" == "-o" ]
then
    echo "Usage $0 [-e|-d|-o] [string/file] [[otp]]"
    exit 1
fi

# Grab the arguments
str=${2:-"Hello World"}
otp=${3:-""}

if [ -f "$str" ]
then
    # User passed in a path to a file, read that in instead
    str=$( cat "$str" )
fi

if [ "$mode" == "-o" ]
then
    # Simply generate and output an OTP based on the provided text
    gen_otp "$str"
    exit 0
fi

if [ "$mode" == "-e" ]
then

    GEN=0
    if [ "$otp" == "" ]
    then
        # OTP hasn't been provided, so return one
        GEN=1
        otp=$( gen_otp "$str" )
    elif [ -f "$otp" ]
    then
        otp=$(cat "$otp")
    fi

    ciphered=$( otp_encrypt "$str" "$otp" )

    if [ "$GEN" == 1 ]
    then
        echo "OTP: $otp"
        echo ""
    fi
    echo "$ciphered"

else

    if [ -f "$otp" ]
    then
        otp=$(cat "$otp")
    fi

    decrypted=$( otp_decrypt "$str" "$otp" )
    echo "$decrypted"

fi

