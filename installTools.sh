#!/bin/bash -eu
mkdir -p /opt/java
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz -P /opt/java/
tar -xzvf /opt/java/jdk-8u131-linux-x64.tar.gz -C /opt/java
rm -rf /opt/java/jdk-8u131-linux-x64.tar.gz
mkdir -p /opt/maven
wget https://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -P /opt/maven/
tar -xvzf /opt/maven/apache-maven-3.5.4-bin.tar.gz -C /opt/maven
rm -rf /opt/maven/apache-maven-3.5.4-bin.tar.gz
mkdir -p /opt/sonarqube_scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip -P /opt/sonarqube_scanner/
unzip /opt/sonarqube_scanner/sonar-scanner-cli-3.2.0.1227-linux.zip -d /opt/sonarqube_scanner
rm -rf /opt/sonarqube_scanner/sonar-scanner-cli-3.2.0.1227-linux.zip
apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
