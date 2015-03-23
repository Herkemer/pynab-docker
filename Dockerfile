FROM ubuntu:14.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -y git-core

RUN apt-get install -y python3 python3-setuptools python3-pip
RUN apt-get install -y libxml2-dev libxslt-dev libyaml-dev

RUN apt-get install -y postgresql-server-dev-9.3 postgresql-client

RUN apt-get install -y unrar

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

RUN git clone https://github.com/Murodese/pynab.git /opt/pynab

RUN pip3 install -r /opt/pynab/requirements.txt

RUN pip3 install uwsgi

WORKDIR /opt/pynab
