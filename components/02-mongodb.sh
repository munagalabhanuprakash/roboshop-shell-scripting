#!/usr/bin/env bash

source components/00-commons.sh
CHECKUSER

ECHO "Setup MongoDB repos."
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG_FILE}
COMMANDSTATUSCHEK $?

ECHO "Install MongoDB"
yum install -y mongodb-org &>>${LOG_FILE}
COMMANDSTATUSCHEK $?


ECHO "Update Listen IP address from 127.0.0.1 to 0.0.0.0 in config file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
COMMANDSTATUSCHEK $?


ECHO "restart the service"
systemctl restart mongod &>>${LOG_FILE} && systemctl enable mongod &>>${LOG_FILE}
COMMANDSTATUSCHEK $?


ECHO "Download the schema and load it."
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>${LOG_FILE}
COMMANDSTATUSCHEK $?

cd mongodb-main &&

ECHO "Unzip the schema"
cd /tmp && unzip -o mongodb.zip &>>${LOG_FILE} && cd mongodb-main

ECHO "Load Schema"
mongo < catalogue.js &>>${LOG_FILE} && mongo < users.js &>>${LOG_FILE}
COMMANDSTATUSCHEK $?

