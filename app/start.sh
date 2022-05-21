#!/bin/sh
PUBLIC_IP=$(curl https://checkip.amazonaws.com)
PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
RANDOM_STRING=$(head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 30 | head -n 1)
echo "<div class="container1"> public ip: $PUBLIC_IP<br> private ip: $PRIVATE_IP<br> random static string unique for each container: <br> $RANDOM_STRING </div>" >> /usr/src/app/templates/index.html
python /usr/src/app/app.py
