FROM t4skforce/jenkins-slave

USER root

WORKDIR /tmp/
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install python python-pip python3 python3-pip wget \
  && wget https://www.python.org/ftp/python/3.5.5/Python-3.5.5.tar.xz \
  && tar xzvf Python-3.5.5.tar.xz \
  && cd Python-3.5.0 \
  && ./configure \
  && make \
  && make install \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

USER jenkins
