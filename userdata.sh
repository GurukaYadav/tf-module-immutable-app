#!/bin/bash

if [ -f /etc/nginx/default.d/roboshop.conf ]; then
  sed -i -e "s/ENV/${ENV}/" /etc/nginx/default.d/roboshop.conf /etc/filebeat/filebeat.yml
  systemctl restart nginx
  systemctl restart filebeat
  exit
fi
MEM=$(echo $(free -m  | grep ^Mem | awk '{print $2}')*0.8 |bc | awk -F . '{print $1}')
sed -i -e "s/ENV/${ENV}/" -e "s/DOCDB_ENDPOINT/${DOCDB_ENDPOINT}/" -e "/java/ s/MEM/$MEM/g" -e "s/REDIS_ENDPOINT/${REDIS_ENDPOINT}/" -e "s/RDS_ENDPOINT/${RDS_ENDPOINT}/" -e "s/DOCDB_USER/${DOCDB_USER}/" -e "s/RABBITMQ_USER_PASSWORD/${RABBITMQ_USER_PASSWORD}/"  -e  "s/DOCDB_PASS/${DOCDB_PASS}/" /etc/systemd/system/${COMPONENT}.service /etc/filebeat/filebeat.yml

systemctl daemon-reload
systemctl enable ${COMPONENT}
systemctl restart ${COMPONENT}
systemctl restart filebeat

