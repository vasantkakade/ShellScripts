#!/bin/bash
mv /opt/tomcat/logs/catalina.out-20*.gz /opt/tomcat/logs/archieve/
aws s3 sync /opt/tomcat/logs/archieve s3://<Bucket Name>/<folder_name>/
find /opt/tomcat/logs/* -mtime +7 -exec rm {} \;
find /opt/tomcat/logs/archieve/* -mtime +30 -exec rm {} \;

