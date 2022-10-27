#!/usr/bin/env bash

CHECKROOTUSER()
{
USER_ID=$(id -u)
if [ "$USER_ID" -ne "0" ];
then
  echo You are supposed to run these commands using sudo
  exit
else
  echo OK
fi
}