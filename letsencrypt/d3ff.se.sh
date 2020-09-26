#!/bin/bash
systemctl stop nginx.service
certbot certonly --standalone --preferred-challenges http -d d3ff.se -d www.d3ff.se -d api.d3ff.se -d files.d3ff.se -d demos.d3ff.se -d myip.d3ff.se
systemctl start nginx.service
