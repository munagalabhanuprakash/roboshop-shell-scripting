#!/usr/bin/env bash

source components/00-commons.sh
checkRootUser

echo "Installing NGINX.."
yum install nginx -y > /tmp/frontendoutput
commandStatusCheck $?

echo "Enabling NGINX.."
systemctl enable nginx > /tmp/frontendoutput
commandStatusCheck $?

echo "Downloading frontend.zip.."
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" > /tmp/frontendoutput
commandStatusCheck $?

cd /usr/share/nginx/html > /tmp/frontendoutput

echo "removing old files.."
rm -rf * > /tmp/frontendoutput
commandStatusCheck $?

echo "unzipping frontend.zip.."
unzip /tmp/frontend.zip > /tmp/frontendoutput
commandStatusCheck $?

echo "copying extracted content.."
mv frontend-main/* . > /tmp/frontendoutput
mv static/* . > /tmp/frontendoutput
rm -rf frontend-main README.md > /tmp/frontendoutput
commandStatusCheck $?

echo "copying nginx roboshop config.."
mv localhost.conf /etc/nginx/default.d/roboshop.conf > /tmp/frontendoutput
commandStatusCheck $?

echo "restarting nginx.."
systemctl restart nginx > /tmp/frontendoutput
COMMANDSTATUSCHECK $?