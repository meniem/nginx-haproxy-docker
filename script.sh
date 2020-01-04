#!/bin/bash

# Install Docker CE latest version
export DEBIAN_FRONTEND=noninteractive && \
	apt -y update && \
    apt install -y httpd apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add - \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
    apt -y update \
    apt-cache policy docker-ce \
    apt install -y docker-ce


# Install Docker Compose
apt -y update && \
	sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null && \
	sudo chmod +x /usr/local/bin/docker-compose && \
	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Run Docker Compose to build the images and run them in a dcoker network
docker-compose up

# Wait until the containers are up and running
while ! ( curl http://172.16.0.100 ) &&  (curl http://172.16.0.200)
do
  echo "$(date) - Waiting for both Docker containers to be up and running"
  sleep 1
done
echo "$(date) - Welcome to nginx"

# Check the status of the high-availability load-balancer:
curl 172.16.0.2