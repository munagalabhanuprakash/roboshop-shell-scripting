#!/usr/bin/env bash

source components/00-commons.sh
CHECKUSER

ECHO "Installing NGINX.."
yum install nginx -y > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

ECHO "Enabling NGINX.."
systemctl enable nginx > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

ECHO "Downloading frontend.zip.."
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

cd /usr/share/nginx/html > /tmp/frontendoutput.log

ECHO "removing old files.."
rm -rf * > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

ECHO "unzipping frontend.zip.."
unzip /tmp/frontend.zip > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

ECHO "copying extracted content.."
mv frontend-main/* . > /tmp/frontendoutput.log
mv static/* . > /tmp/frontendoutput.log
rm -rf frontend-main README.md > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

ECHO "copying nginx roboshop config.."
mv localhost.conf /etc/nginx/default.d/roboshop.conf > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?

ECHO "restarting nginx.."
systemctl restart nginx > /tmp/frontendoutput.log
COMMANDSTATUSCHEK $?