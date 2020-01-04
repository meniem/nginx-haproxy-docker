# HAProxy load balancer for Nginx servers using Docker

Creates HAProxy load balancer for two Nginx web servers using Docker containers and Bash script. The script will create and configure 3 servers, one load balancer, and two Nginx web servers. HAProxy will be installed on on a single server and then install Nginx web server on the other 2 servers, and HAProxy will act as a load balancer for the Nginx web servers. All of the 3 servers will be containerized using Dockerfile and Docker-Compose.

>HAProxy will run in Layer 4 TCP mode, and will forward the RAW TCP packets from the client to the application servers, all the requests go to HAProxy container, and HAProxy will call either the first Nginx or the second one.

# Prerequisites:
 - Docker.
 - Docker Compose.
 - Pulling Nginx and HAProxy images form Docker Hub.


# Technical details:
 - Docker network subnet is: 172.16.0.0/24
 - HAProxy load balancer IP address is: 172.16.0.2
 - Nginx web server 1 IP address: 172.16.0.10
 - Nginx web server 2 IP address: 172.16.0.20
 - Exposed port for Nginx and HAProxy is: 80
***The above information is saved inside the .env file***


# Repo structure:
[![N|Solid](https://raw.githubusercontent.com/meniem/nginx-haproxy-docker/master/structure.jpg)](https://raw.githubusercontent.com/meniem/nginx-haproxy-docker/master/structure.jpg)

# Installation steps:
 - Clone the repo
 - Run the script (as sudo) from the main script “script.sh” file:

```sh
cd nginx-haproxy-docker
chmod a+x script.sh
./script.sh
```
 - The script will install docker and docker-compose, then execute the docker-compose which will build and start the three servers.
 - Test the load balancer by executing some random curl commands on the HAProxy IP to check the response from both web servers

 ```sh
curl 172.16.0.2
```

 - Benchmark the web servers by sending a punch of requests directly:

 ```sh
ab -n 3000 -c 20 http://172.16.0.2/
```