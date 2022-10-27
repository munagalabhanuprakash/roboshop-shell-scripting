#!/usr/bin/env bash

checkRootUser()
{
USER_ID=$(id -u)
if [ "$USER_ID" -ne "0" ];
then
  echo -e "\e[31mYou are supposed to run these commands using sudo\e[0m"
  exit 1
fi
}

commandStatusCheck()
{
if [ "$?" -eq "0" ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi
#}