#!/usr/bin/env bash

source components/00-commons.sh
CHECKUSER

echo "Installing NGINX.."
yum install nginx -y > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

echo "Enabling NGINX.."
systemctl enable nginx > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

echo "Downloading frontend.zip.."
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

cd /usr/share/nginx/html > /tmp/frontendoutput

echo "removing old files.."
rm -rf * > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

echo "unzipping frontend.zip.."
unzip /tmp/frontend.zip > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

echo "copying extracted content.."
mv frontend-main/* . > /tmp/frontendoutput
mv static/* . > /tmp/frontendoutput
rm -rf frontend-main README.md > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

echo "copying nginx roboshop config.."
mv localhost.conf /etc/nginx/default.d/roboshop.conf > /tmp/frontendoutput
COMMANDSTATUSCHEK $?

echo "restarting nginx.."
systemctl restart nginx > /tmp/frontendoutput
COMMANDSTATUSCHEK $?