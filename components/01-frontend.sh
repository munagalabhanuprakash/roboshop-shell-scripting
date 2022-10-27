#!/usr/bin/env bash

source components/00-commons.sh
CHECKROOTUSER
echo "Installing NGINX.."
yum install nginx -y > /tmp/frontendoutput

echo "Enabling NGINX.."
systemctl enable nginx > /tmp/frontendoutput

echo "Downloading frontend.zip.."
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" > /tmp/frontendoutput

cd /usr/share/nginx/html > /tmp/frontendoutput

echo "removing old files.."
rm -rf * > /tmp/frontendoutput

echo "unzipping frontend.zip.."
unzip /tmp/frontend.zip > /tmp/frontendoutput

echo "copying extracted content.."
mv frontend-main/* . > /tmp/frontendoutput
mv static/* . > /tmp/frontendoutput
rm -rf frontend-main README.md > /tmp/frontendoutput

echo "copying nginx roboshop config.."
mv localhost.conf /etc/nginx/default.d/roboshop.conf > /tmp/frontendoutput

echo "restarting nginx.."
systemctl restart nginx > /tmp/frontendoutput
