#!/bin/bash

yum install -y httpd

systemctl start httpd

systemctl enable httpd

echo "This is my first project" > /var/www/html/index.html