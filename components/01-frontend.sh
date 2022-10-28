#!/usr/bin/env bash

source components/00-commons.sh
CHECKUSER

ECHO "Installing NGINX.."
yum install nginx -y >> ${LOG_FILE}
COMMANDSTATUSCHEK $?

ECHO "Enabling NGINX.."
systemctl enable nginx >> ${LOG_FILE}
COMMANDSTATUSCHEK $?

ECHO "Downloading frontend.zip.."
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >> ${LOG_FILE}
COMMANDSTATUSCHEK $?

cd /usr/share/nginx/html >> ${LOG_FILE}

ECHO "removing old files.."
rm -rf * >> ${LOG_FILE} 
COMMANDSTATUSCHEK $?

ECHO "unzipping frontend.zip.."
unzip /tmp/frontend.zip >> ${LOG_FILE}
COMMANDSTATUSCHEK $?

ECHO "copying extracted content.."
mv frontend-main/* . >> ${LOG_FILE}
mv static/* . >> ${LOG_FILE}
rm -rf frontend-main README.md >> ${LOG_FILE}
COMMANDSTATUSCHEK $?

ECHO "copying nginx roboshop config.."
mv localhost.conf /etc/nginx/default.d/roboshop.conf >> ${LOG_FILE}
COMMANDSTATUSCHEK $?

ECHO "restarting nginx.."
systemctl restart nginx >> ${LOG_FILE}
COMMANDSTATUSCHEK $?