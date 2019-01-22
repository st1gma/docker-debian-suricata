##########
# Suricata upgradable container
# runs entirely in userspace
# Created by Juan Figuera


# linked container volumes:
# /data/suricata => /data/

# ports (we use high ports to avoid root), you can change below
#

# source
FROM debian:stable-slim

#update environment
RUN apt-get update && \
  apt-get install software-properties-common -y && \
  add-apt-repository ppa:oisf/suricata-stable -y

WORKDIR /tmp
RUN apt-get install libpcre3 libpcre3-dev build-essential autoconf automake libtool libpcap-dev libnet1-dev libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev libjansson-dev pkg-config libnetfilter-queue-dev geoip-bin geoip-database apt-transport-https wget -y  && \
  wget -O geoipupdate.deb "https://github.com/maxmind/geoipupdate/releases/download/v4.0.2/geoipupdate_4.0.2_linux_amd64.deb" && \
  dpkg -i /tmp/geoipupdate.deb && \
  apt-get install suricata -y && \
  apt-get install python-pip python-yaml -y && \
  pip install --pre --upgrade suricata-update

COPY suricata-update.sh /etc/suricata/suricata-update.sh
COPY suricata.yaml /etc/suricata/suricata.yaml

# UPDATE initial rules. To add rules create a my.rules in the stage/pcaps directory with the rule needed. It will be loaded automatically
RUN /etc/suricata/suricata-update.sh

# cleanup
RUN apt-get clean -y && rm -rf /var/lib/apt/lists/*

WORKDIR /data

ENTRYPOINT ["suricata","-s","/data/configs/custom.rules","-l","/data/logs","-k","none"]
