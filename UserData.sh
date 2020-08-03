#!/bin/bash
# This script was created for simple understanding of UserData in AWS.
# UserData can be used to perform common automated configuration tasks and even run scripts after the instance starts.
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello from $(hostname -f)" > /var/www/html/index.html
