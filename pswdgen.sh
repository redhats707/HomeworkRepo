#!/bin/bash

  
# Password's length
echo "please enter the length of the password"  
  
read  PASS_LENGTH 
  
# loop will create 5 passwords according to user's input
for p in $(seq 1 5);                                   
do 
    openssl rand -base64 48 | cut -c1-$PASS_LENGTH 
done
