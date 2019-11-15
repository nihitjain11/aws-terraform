#!/bin/bash -xe

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo apt-get update

sudo apt-get install openjdk-8-jdk nginx -y

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.7.1.deb
sudo dpkg -i elasticsearch-6.7.1.deb

sudo sed -i '55s/#network.host: 192.168.0.1/network.host: localhost/' /etc/elasticsearch/elasticsearch.yml
sudo sed -i '59s/#//' /etc/elasticsearch/elasticsearch.yml

wget https://artifacts.elastic.co/downloads/logstash/logstash-6.7.1.deb
sudo dpkg -i logstash-6.7.1.deb 

wget https://artifacts.elastic.co/downloads/kibana/kibana-6.7.1-amd64.deb
sudo dpkg -i kibana-6.7.1-amd64.deb 

sudo sed -i '2s/#//' /etc/kibana/kibana.yml 
sudo sed -i '7s/#//' /etc/kibana/kibana.yml 

wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.7.1-amd64.deb
sudo dpkg -i filebeat-6.7.1-amd64.deb

sudo service elasticsearch start
sudo service logstash start
sudo service kibana start
sudo service filebeat start

echo "
server {
	listen 80 default_server;
	listen [::]:80 default_server;
 	# root /var/www/html;
	# index index.html index.htm index.nginx-debian.html;
	server_name _;
	location / {
		proxy_pass http://localhost:5601;
	}
}" > /etc/nginx/sites-enabled/default

sudo service nginx restart

# sudo service elasticsearch status
# sudo service logstash status
# sudo service kibana status
# tail -f /var/log/user-data.log 