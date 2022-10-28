#!/usr/bin/env bash

CHECKUSER()
{
USER_ID=$(id -u)
if [ "$USER_ID" -ne "0" ];
then
  echo -e "\e[31mYou are supposed to run these commands using sudo\e[0m"
  exit 1
fi
}

COMMANDSTATUSCHEK()
{
if [ "$?" -eq "0" ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  echo -e "[31m Check the error log in\e[0m" ${LOG_FILE}"
  exit 1
fi
}

LOG_FILE=/tmp/frontendoutput.log
rm -f $LOG_FILE

ECHO()
{
  echo -e "===================================$1===================================\n" >> ${LOG_FILE}
  echo "$1"
}