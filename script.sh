#! /bin/bash
sudo rm -rf DevOpsB14
sudo apt-get update
sudo apt-get install -y nginx jq
sudo git clone -b DevOpsB14 https://github.com/NagarjunaReddy879-reddy/dockertest1.git DevOpsB14
cd DevOpsB14
sudo cp index.html /var/www/html/index.nginx-debian.html
sudo cp scorekeeper.js /var/www/html/scorekeeper.js
sudo cp style.css /var/www/html/style.css
sudo service nginx restart 