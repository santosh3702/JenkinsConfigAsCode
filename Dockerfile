#
# Docker file to build jenkins
#

# Use jenkins/jenkins:2.155  as the base image
FROM jenkins/jenkins:2.155

# Author Name

MAINTAINER coedevops

#ENV HTTP_PROXY "http://10.112.78.112:3128"

#ENV HTTPS_PROXY "http://10.112.78.112:3128"

# Adding file  plugins.txt

ADD JCasC/*.yaml /var/jcasc_configs/

ENV CASC_JENKINS_CONFIG="/var/jcasc_configs"

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY hooks/src/init/*.groovy /usr/share/jenkins/ref/init.groovy.d/

ADD plugins.txt /usr/share/jenkins/ref/plugins.txt


# Adding file  installTools.sh


ADD installTools.sh /usr/share/installTools.sh

# Adding file  dockerGroupCreation.sh

ADD dockerGroupCreation.sh /usr/share/dockerGroupCreation.sh


# Adding file  jenkins-entrypoint.sh


ADD jenkins-entrypoint.sh /usr/share/jenkins-entrypoint.sh



# Run utility /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Run utility USER root
USER root

# Run utility chmod 777 /usr/share/installTools.sh
RUN chmod 777 /usr/share/installTools.sh

# Run utility chmod 777 /usr/share/dockerGroupCreation.sh
RUN chmod 777 /usr/share/dockerGroupCreation.sh

# Run utility chmod 777 /usr/share/jenkins-entrypoint.sh
RUN chmod 777 /usr/share/jenkins-entrypoint.sh

# Run utility sh -x /usr/share/installTools.sh
RUN sh -x /usr/share/installTools.sh

# Define Volume /var/run/docker.sock
VOLUME /var/run/docker.sock

# Define Volume /var/jenkins_home
#VOLUME /var/jenkins_home

EXPOSE 8080

# Expose port 50000
EXPOSE 50000

# Define the starting point
ENTRYPOINT  ["/usr/share/jenkins-entrypoint.sh"]
