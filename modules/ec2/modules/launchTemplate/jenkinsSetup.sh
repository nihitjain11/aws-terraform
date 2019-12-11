#!/bin/bash -xe

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo apt-get update 
sudo apt-get install openjdk-8-jdk -y
echo -en "\n Java version is "
java -version
echo "Starting Jenkins Installation"
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update 
sudo apt-get install jenkins=2.176.4 -y
#sudo usermod -a -G root jenkins
echo -en "\n Starting Jenkins \n"
sudo systemctl start jenkins
echo -en "\n Jenkins Service Status \n"
sudo systemctl status jenkins
# echo -en "\n\nJenkins Admin login password is "
# sudo cat /var/lib/jenkins/secrets/initialAdminPassword
