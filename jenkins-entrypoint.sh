#! /bin/bash -e

sh /usr/share/dockerGroupCreation.sh
 
exec /usr/local/bin/jenkins.sh "$@"
