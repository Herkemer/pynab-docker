FROM ubuntu:14.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -y git-core

RUN apt-get install -y python3 python3-setuptools python3-pip
RUN apt-get install -y libxml2-dev libxslt-dev libyaml-dev

RUN apt-get install -y liblapack-dev

RUN apt-get install -y postgresql-server-dev-9.3 postgresql-client

RUN apt-get install -y unrar

# For the API
RUN apt-get install -y nginx uwsgi supervisor

# For webui
run apt-get install -y npm nodejs-legacy ruby ruby-compass

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

RUN rm /etc/nginx/sites-enabled/default

RUN git clone https://github.com/Murodese/pynab.git /opt/pynab

RUN pip3 install -r /opt/pynab/requirements.txt

RUN pip3 install uwsgi

# Generate the webui pieces
RUN cd /opt/pynab/webui; npm install
RUN cd /opt/pynab/webui; npm install -g grunt-cli
RUN cd /opt/pynab/webui; npm install -g bower
RUN cd /opt/pynab/webui; bower install --allow-root
RUN cd /opt/pynab/webui; grunt build

WORKDIR /opt/pynab
