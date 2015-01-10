FROM debian:jessie

# Copy-pasted phantomjs Dockerfile

# Env
ENV PHANTOMJS_VERSION 1.9.8
ENV DEBIAN_FRONTEND noninteractive

# Commands
RUN \
  echo "103.22.220.133 http.debian.net" >> /etc/hosts && \
  apt-get update && \
  apt-get install -y --force-yes wget libfreetype6 libfontconfig bzip2

RUN \
  mkdir -p /srv/var && \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  cp /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs

## From here it's for my sake.

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD . /usr/src/app

CMD [ "phantomjs", "main.js" ]
