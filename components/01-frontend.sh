#!/usr/bin/env bash

source components/00-commons.sh
CHECKROOTUSER

yum install nginx -y > /tmp/frontendoutput
systemctl enable nginx > /tmp/frontendoutput
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" > /tmp/frontendoutput
cd /usr/share/nginx/html > /tmp/frontendoutput
rm -rf * > /tmp/frontendoutput
unzip /tmp/frontend.zip > /tmp/frontendoutput
mv frontend-main/* . > /tmp/frontendoutput
mv static/* . > /tmp/frontendoutput
rm -rf frontend-main README.md > /tmp/frontendoutput
mv localhost.conf /etc/nginx/default.d/roboshop.conf > /tmp/frontendoutput
systemctl restart nginx > /tmp/frontendoutput
