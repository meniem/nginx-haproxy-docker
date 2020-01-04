FROM haproxytech/haproxy-ubuntu:latest

# install third party tools
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y inotify-tools dnsmasq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose web ports
EXPOSE 80 443

# Expose administrative ports
EXPOSE 81 82 88

ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD haproxy.sh /
RUN chmod a+x /haproxy.sh

ENTRYPOINT /haproxy.sh
