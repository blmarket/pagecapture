FROM node:0.10

# Copy-pasted phantomjs Dockerfile

# Env
ENV PHANTOMJS_VERSION 1.9.8
ENV DEBIAN_FRONTEND noninteractive

# Commands
RUN \
  apt-get update && \
  apt-get install -y wget libfreetype6 libfontconfig bzip2 && \
  mkdir -p /srv/var && \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  cp /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs

## From here it's for my sake.

RUN npm install -g coffee-script

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD package.json /usr/src/app/
RUN npm install
RUN npm install phantom

ADD . /usr/src/app

CMD [ "coffee", "main.coffee" ]
