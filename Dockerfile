## metadata
FROM        ubuntu:12.04
MAINTAINER  Markus Hubig <mhubig@imko.de>

## update & upgrade
RUN     echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list
RUN     apt-get -y update
RUN     apt-get -y upgrade

## install required software
RUN     apt-get install -y -q curl
RUN     apt-get install -y -q git
RUN     apt-get install -y -q wget
RUN     apt-get install -y -q gawk
RUN     apt-get install -y -q rsync
RUN     apt-get install -y -q unzip
RUN     apt-get install -y -q texinfo
RUN     apt-get install -y -q chrpath
RUN     apt-get install -y -q diffstat
RUN     apt-get install -y -q python-dev
RUN     apt-get install -y -q python-pip
RUN     apt-get install -y -q build-essential

## set a password
RUN     echo "root:root" | chpasswd

## setup buildbot master
RUN     pip install boto
RUN     pip install fabric
RUN     pip install buildbot
RUN     mkdir -p /data
ADD     ./master /data/master
ADD     ./fabfile.py /data

## setup supervisor scripts
ADD     ./supervisord/ /etc/supervisor/conf.d/

## expose some ports
EXPOSE  22 9989 8080 8011

## set the workdir
WORKDIR /data

## RUN command
CMD     ["/usr/local/bin/fab", "run"]
