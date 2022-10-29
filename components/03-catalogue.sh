#!/usr/bin/env bash

source components/00-commons.sh
CHECKUSER

#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install

#1. Update SystemD file with correct IP addresses
 #
 #    Update `MONGO_DNSNAME` with MongoDB Server IP

 # mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
 # systemctl daemon-reload
 # systemctl start catalogue
 # systemctl enable catalogue

ECHO "Configure NodeJS Yum Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${LOG_FILE}
COMMANDSTATUSCHECK $?

ECHO "Install NodeJS"
yum install nodejs gcc-c++ -y &>> ${LOG_FILE}
COMMANDSTATUSCHECK $?

id roboshop &>> ${LOG_FILE}
if [ $? -ne 0 ]; then
  ECHO "Adding Application user"
  useradd roboshop &>> ${LOG_FILE}
  COMMANDSTATUSCHECK $?
fi


